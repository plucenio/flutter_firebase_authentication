import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthenticationDatasource {
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password);
}
