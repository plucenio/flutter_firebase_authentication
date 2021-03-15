import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/logged_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'create_account_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void initState() {
    emailController.clear();
    passwordController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                  Modular.to.pushNamedAndRemoveUntil(
                      LoggedPage.route, ModalRoute.withName("/"));
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () async {
                Modular.to.pushNamed(CreateAccountPage.route);
              },
              child: Text("Create account"),
            )
          ],
        ),
      ),
    );
  }
}
