import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authentication/core/errors/failures.dart';
import 'package:flutter_firebase_authentication/features/authentication/data/datasources_interfaces/firebase_authentication_datasource.dart';
import 'package:flutter_firebase_authentication/features/authentication/domain/repositories_interfaces/firebase_authentication_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FirebaseAuthenticationRepository
    implements IFirebaseAuthenticationRepository {
  @override
  Future<Either<IFailure, UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential =
          await Modular.get<IFirebaseAuthenticationDatasource>()
              .signInWithEmailAndPassword(email, password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(e.message));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, UserCredential>> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential =
          await Modular.get<IFirebaseAuthenticationDatasource>()
              .createUserWithEmailAndPassword(email, password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(e.message));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, void>> sendPasswordResetEmail(String email) async {
    try {
      return Right(await Modular.get<IFirebaseAuthenticationDatasource>()
          .sendPasswordResetEmail(email));
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(e.message));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, void>> signOut() async {
    try {
      return Right(
          await Modular.get<IFirebaseAuthenticationDatasource>().signOut());
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(e.message));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
