import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sns_firebase/model/account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp({required String email, required String pass}) async {
    try {
      UserCredential newAccount = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      print('auth登録完了');
      return newAccount;
    } on FirebaseAuthException catch(error) {
      print('auth登録エラー: ${error}');
      return false;
    }
  }

  static Future<dynamic> signIn({required String email, required String pass}) async {
    try {
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass
      );
      currentFirebaseUser = _result.user;
      print('authサインイン完了');
      return _result;
    } on FirebaseAuthException catch(error) {
      print('authサインインエラー: ${error}');
      return false;
    }
  }
}