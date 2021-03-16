import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/usecases/firebase_authentication_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
                (await Modular.get<IFirebaseAuthenticationUsecase>()
                        .createUserWithEmailAndPassword(
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
                  (r) async {
                    await ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text("${r.user.email} created."),
                            backgroundColor: Colors.green,
                          ),
                        )
                        .closed;
                    Modular.to.pushReplacementNamed("/");
                  },
                );
              },
              child: Text("Create account"),
            )
          ],
        ),
      ),
    );
  }
}
