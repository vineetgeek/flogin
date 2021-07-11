import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late UserCredential user;
  User? users = FirebaseAuth.instance.currentUser;
  var currentUser = FirebaseAuth.instance.currentUser;

  bool isSignedIn = false;

  checkAuthentication() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SigninPage");
      }
    });
  }

  navigateToSignupScreen() {
    Navigator.pushReplacementNamed(context, "/SignupPage");
  }

  getUser() async {
    // CurrentUser currentUser = await _auth.currentUser();
    //ISSUE:  https://github.com/flutter/flutter/issues/19746
    // await firebaseUser?.reload();
    // firebaseUser = await _auth.currentUser();

    if (currentUser != null) {
      setState(() {
        // this.user = firebaseUser;
        this.isSignedIn = true;
      });
    }
    print(this.user);
  }

  signout() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    // this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
          child: Center(
              // child: !isSignedIn
              //     // ? CircularProgressIndicator()
              //     ? Column(
              child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(50),
            child: Image(
              image: AssetImage('assets/vg.png'),
              height: 100,
              width: 100,
            ),
          ),
          Container(
            padding: EdgeInsets.all(50.0),
            child: Text(
              // "Hello, ${user.displayName}, you are logged in as ${users!.email}",
              "Hello, you are logged in as ${currentUser!.uid}",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              color: Colors.blue,
              padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: signout,
              child: Text('Signout',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
            ),
          ),
          GestureDetector(
            onTap: navigateToSignupScreen,
            child: Text('Create an account?',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0)),
          )
        ],
      ))),
    );
  }
}
