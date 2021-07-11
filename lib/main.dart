import 'package:flutter/material.dart';
import 'home.dart';
import 'signin.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'loginapp',
        theme: ThemeData.dark(),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          "/SigninPage": (BuildContext context) => SignInPage(),
          "/SignupPage": (BuildContext context) => SignupPage(),
        });
  }
}
