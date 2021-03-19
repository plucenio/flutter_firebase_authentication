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
    var sizeAnimation = SizeTween(begin: Size(450, 450), end: Size(500, 500))
        .animate(animationController);
    var sizeTextAnimation =
        Tween(begin: 2.25, end: 2.5).animate(animationController);
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
                                "Mensagem de teste",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .fontSize *
                                        sizeTextAnimation.value),
                              )),
                              color: Colors.white,
                              height: sizeAnimation.value.height,
                              width: sizeAnimation.value.width,
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
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
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
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
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
