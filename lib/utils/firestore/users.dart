import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sns_firebase/model/account.dart';
import 'package:flutter_sns_firebase/utils/authentication.dart';

class UserFirestore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _fireStoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'description': newAccount.description,
        'image_path': newAccount.imagePath,
        'created_time': DateTime.now(),
        'updated_time': DateTime.now(),
      });
      print('新規ユーザー作成完了');
      return true;
    } on FirebaseException catch(error) {
      print('新規ユーザー作成エラー: ${error}');
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc('uid').get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
        id: uid,
        name: data['name'],
        userId: data['userId'],
        description: data['description'],
        imagePath: data['imagePath'],
        createdTime: data['created_time'],
        updatedTime: data['updated_time'],
      );
      Authentication.myAccount = myAccount;
      print('ユーザー取得完了');
      return true;
    } on FirebaseException catch(error) {
      print('ユーザー取得エラー: ${error}');
      return false;
    }
  }
}