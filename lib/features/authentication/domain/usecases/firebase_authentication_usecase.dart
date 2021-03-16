import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authentication/core/errors/failures.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/repositories_interfaces/firebase_authentication_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IFirebaseAuthenticationUsecase {
  Future<Either<IFailure, UserCredential>> signInWithEmailAndPassword(
      String email, String password);
}

class FirebaseAuthenticationUsecase implements IFirebaseAuthenticationUsecase {
  @override
  Future<Either<IFailure, UserCredential>> signInWithEmailAndPassword(
      String email, String password) {
    return Modular.get<IFirebaseAuthenticationRepository>()
        .signInWithEmailAndPassword(email, password);
  }
}
