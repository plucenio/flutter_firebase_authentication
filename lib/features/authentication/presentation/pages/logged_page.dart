import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/firebase_authentication_usecase.dart';

class LoggedPage extends StatefulWidget {
  static String route = "/logged";
  LoggedPage({Key key}) : super(key: key);

  @override
  _LoggedPageState createState() => _LoggedPageState();
}

class _LoggedPageState extends State<LoggedPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logged"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                (await Modular.get<IFirebaseAuthenticationUsecase>()
                        .sendPasswordResetEmail("plucenio@hotmail.com"))
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
                            content: Text("Password changed"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),
                          ),
                        )
                        .closed;
                    Modular.to.pushReplacementNamed("/");
                  },
                );
              },
              child: Text("Change password"),
            ),
            ElevatedButton(
              onPressed: () async {
                (await Modular.get<IFirebaseAuthenticationUsecase>().signOut())
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
                            content: Text("Logged out"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),
                          ),
                        )
                        .closed;
                    Modular.to.pushReplacementNamed("/");
                  },
                );
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
