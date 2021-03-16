import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  static String route = "/create_account";
  CreateAccountPage({Key key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create account"),
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
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Create account"),
            )
          ],
        ),
      ),
    );
  }
}
