import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/usecases/usecases.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    var factor = 1.1;
    var sizeAnimation =
        SizeTween(begin: Size(400, 400), end: Size(400 * factor, 400 * factor))
            .animate(animationController);
    var sizeTextAnimation =
        Tween(begin: 1, end: factor).animate(animationController);
    var opacityAnimation =
        Tween(begin: 0.5, end: 0.8).animate(animationController);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestão de studio"),
        centerTitle: true,
        elevation: 5,
      ),
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
                fit: FlexFit.tight,
                child: Center(
                  child: AnimatedBuilder(
                    animation: sizeAnimation,
                    builder: (context, snapshot) {
                      return AnimatedBuilder(
                        animation: opacityAnimation,
                        builder: (context, snapshot) {
                          return Opacity(
                            opacity: opacityAnimation.value,
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Crie sua conta gratuitamente!",
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .fontSize *
                                          sizeTextAnimation.value),
                                ),
                              ),
                              height: sizeAnimation.value.height,
                              width: sizeAnimation.value.width,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.white70,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              validator: (String value) {
                                return value.isEmpty ||
                                        (!value.contains('@') ||
                                            !value.contains('.com'))
                                    ? 'Email inválido'
                                    : null;
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Senha',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  (await Modular.get<
                                              IFirebaseAuthenticationUsecase>()
                                          .signInWithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text))
                                      .fold(
                                    (l) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "É necessário informar um email válido."),
                                      backgroundColor: Colors.amber,
                                    ),
                                  );
                                }
                              },
                              child: Text("Entrar"),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                Modular.to.pushNamed(CreateAccountPage.route);
                              },
                              child: Text("Criar conta"),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  (await Modular.get<
                                              IFirebaseAuthenticationUsecase>()
                                          .sendPasswordResetEmail(
                                              emailController.text))
                                      .fold(
                                    (l) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(l.message),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    (r) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Um email para gerar uma nova senha foi enviado."),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "É necessário informar um email válido."),
                                      backgroundColor: Colors.amber,
                                    ),
                                  );
                                }
                              },
                              child: Text("Esqueci minha senha"),
                            )
                          ],
                        ),
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
