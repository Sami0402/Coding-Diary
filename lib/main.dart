import 'package:coding_diary/firebase_options.dart';
import 'package:coding_diary/routes.dart';
import 'package:coding_diary/src/providers/auth_provider.dart';
import 'package:coding_diary/src/utils/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> AuthProvider())
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding Diary',
      home: AuthGate(),
      routes: AppRoute.routes,
    );
  }
}

