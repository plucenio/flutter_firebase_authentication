import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/usecases/usecases.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pages.dart';

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
    super.initState();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Flexible(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.white70,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            autovalidateMode: AutovalidateMode.always,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            ),
                            validator: (String value) {
                              return value.length > 0 &&
                                      (!value.contains('@') ||
                                          !value.contains('.com'))
                                  ? 'Email inválido'
                                  : null;
                            },
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              (await Modular.get<
                                          IFirebaseAuthenticationUsecase>()
                                      .signInWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text))
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
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              Modular.to.pushNamed(CreateAccountPage.route);
                            },
                            child: Text("Create account"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
