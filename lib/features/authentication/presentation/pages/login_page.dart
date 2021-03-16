import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/usecases/firebase_authentication_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'logged_page.dart';
import 'pages/../create_account_page.dart';

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
                (await Modular.get<IFirebaseAuthenticationUsecase>()
                        .signInWithEmailAndPassword(
                            emailController.text, passwordController.text))
                    .fold(
                  (l) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  (r) {
                    Modular.to.pushReplacementNamed(
                      LoggedPage.route,
                    );
                  },
                );
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
