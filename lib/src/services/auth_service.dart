import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String? emailError;
  static bool userNameExist = false;
  static String? commonError;

  Future<void> saveUsername(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }
  
  Future<String> getUsername() async{
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? 'Anonymous User';

      return username;
    } 

  // REGISTER
  Future<String?> registerUser({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      emailError = null;
      // Check if username already exists
      final enterdUsername = username.trim().toLowerCase();
      if (userNameExist) return null;

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      // On Successful Account creation, save the details in firestore
      if (user != null) {
        _firestore.collection('users').doc(user.uid).set({
          "fullName": fullName,
          "username": username,
          "email": email,
          "password": password,
        });

        // Add username into 'username' collection
        _firestore.collection('usernames').doc(enterdUsername).set({
          'uid': user.uid,
        });
        await saveUsername(username);
        return "Success";
      }
      return "Registration failed. User object is null.";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emailError = 'The account already exists for that email.';
        return null;
      }
      emailError = e.message;
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  // LOGIN
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        final data = await _firestore
            .collection('usernames')
            .where('uid', isEqualTo: user.uid)
            .limit(1)
            .get();

        final username = data.docs[0].id;

        await saveUsername(username);

        return 'Success';
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        commonError = 'Incorrect email or password. Try again.';
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  // RESET PASSWORD
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emailError = null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emailError = 'There is no user corresponding to the email address';
      }
    }
  }

  // GOOGLE SIGN-IN
  Future<bool> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '830320404723-q5366fsq5un3319u8s0d46opecgi434b.apps.googleusercontent.com',
      );
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;

      if (user != null) {
        final username = (user.displayName ?? user.email?.split('@')[0]) ?? 'Anonymous User';
         await saveUsername(username);
        return true;
      }
      return false;
    } on GoogleSignInException catch (e) {
      throw Exception(e);
    }
  }
}
