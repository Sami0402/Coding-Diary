class Validators {

  // EMAIL
  static String? email(String? value){
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (value == null || value.trim().isEmpty){
      return 'Please enter your email address';
    } else if (!emailRegex.hasMatch(value)){
      return 'Please enter a valid email address';
    } 
    return null;
  }

  // PASSWORD
  static String? password(String? value){
    final passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
    );
    if (value == null || value.isEmpty){
      return 'Please enter your password';
    } else if (!passwordRegExp.hasMatch(value)){
      return 'Must be 8+ chars with uppercase, lowercase, number & special char';
    } 
    return null;
  }

  // FULL NAME
  static String? fullName(String? value){
    if (value == null || value.trim().isEmpty){
      return 'Please enter your name';
    }
    return null;
  }

  // USERNAME
  static String? username(String? value){
    if (value == null || value.trim().isEmpty){
      return 'Please enter a username';
    }
    return null;
  }

}