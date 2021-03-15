import 'package:flutter_firebase_authentication/create_account_page.dart';
import 'package:flutter_firebase_authentication/logged_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => LoginPage(),
    ),
    ChildRoute(
      CreateAccountPage.route,
      child: (_, __) => CreateAccountPage(),
    ),
    ChildRoute(
      LoggedPage.route,
      child: (_, __) => LoggedPage(),
    ),
  ];
}
