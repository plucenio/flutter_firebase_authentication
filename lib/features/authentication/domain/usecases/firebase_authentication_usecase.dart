import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authentication/core/errors/failures.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/repositories_interfaces/repositories.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IFirebaseAuthenticationUsecase {
  Future<Either<IFailure, UserCredential>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<IFailure, UserCredential>> createUserWithEmailAndPassword(
      String email, String password);

  Future<Either<IFailure, void>> sendPasswordResetEmail(String email);

  Future<Either<IFailure, void>> signOut();
}

class FirebaseAuthenticationUsecase implements IFirebaseAuthenticationUsecase {
  @override
  Future<Either<IFailure, UserCredential>> signInWithEmailAndPassword(
      String email, String password) {
    return Modular.get<IFirebaseAuthenticationRepository>()
        .signInWithEmailAndPassword(email, password);
  }

  @override
  Future<Either<IFailure, UserCredential>> createUserWithEmailAndPassword(
      String email, String password) {
    return Modular.get<IFirebaseAuthenticationRepository>()
        .createUserWithEmailAndPassword(email, password);
  }

  @override
  Future<Either<IFailure, void>> signOut() {
    return Modular.get<IFirebaseAuthenticationRepository>().signOut();
  }

  @override
  Future<Either<IFailure, void>> sendPasswordResetEmail(String email) {
    return Modular.get<IFirebaseAuthenticationRepository>()
        .sendPasswordResetEmail(email);
  }
}
