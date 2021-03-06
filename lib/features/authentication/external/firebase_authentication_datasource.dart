import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authentication/features/authentication/data/datasources_interfaces/datasources.dart';

class FirebaseAuthenticationDatasource
    implements IFirebaseAuthenticationDatasource {
  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
