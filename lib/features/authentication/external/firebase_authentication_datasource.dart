import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authentication/features/authentication/data/datasources_interfaces/firebase_authentication_datasource.dart';

class FirebaseAuthenticationDatasource
    implements IFirebaseAuthenticationDatasource {
  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
