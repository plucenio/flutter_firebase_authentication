import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_firebase_authentication/features/authentication/data/datasources_interfaces/datasources.dart';
import 'package:flutter_firebase_authentication/features/authentication/data/repositories/repositories.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/repositories_interfaces/repositories.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/usecases/usecases.dart';
import 'package:flutter_firebase_authentication/features/authentication/external/external.dart';
import 'package:flutter_firebase_authentication/features/authentication/presentation/pages/pages.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<IFirebaseAuthenticationDatasource>(
        (i) => FirebaseAuthenticationDatasource()),
    Bind<IFirebaseAuthenticationRepository>(
        (i) => FirebaseAuthenticationRepository()),
    Bind<IFirebaseAuthenticationUsecase>(
        (i) => FirebaseAuthenticationUsecase()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => LoginPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      CreateAccountPage.route,
      child: (_, __) => CreateAccountPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      LoggedPage.route,
      child: (_, __) => LoggedPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
