import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_firebase/model/account.dart';
import 'package:flutter_sns_firebase/utils/authentication.dart';
import 'package:flutter_sns_firebase/utils/firestore/users.dart';
import 'package:image_picker/image_picker.dart';

class createAccountPage extends StatefulWidget {
  const createAccountPage({Key? key}) : super(key: key);

  @override
  State<createAccountPage> createState() => _createAccountPageState();
}

class _createAccountPageState extends State<createAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;
  ImagePicker picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImage(String uid) async {
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();
    await ref.child(uid).putFile(image!);
    String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
    print('image_path: ${downloadUrl}');
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('新規登録', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(children: [
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: () => getImageFromGallery(),
              child: CircleAvatar(
                foregroundImage: image == null ? null : FileImage(image!),
                radius: 40,
                child: Icon(Icons.add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: '名前'
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: userIdController,
                decoration: InputDecoration(
                  hintText: 'ユーザーID'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: 300,
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: '自己紹介'
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'メールアドレス'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: 'パスワード'
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: () async {
              if(nameController.text.isNotEmpty
                && userIdController.text.isNotEmpty
                && descriptionController.text.isNotEmpty
                && emailController.text.isNotEmpty
                && passController.text.isNotEmpty
                && image !=null) {
                  var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                  if(result is UserCredential) {
                    String imagePath = await uploadImage(result.user!.uid);
                    Account newAccount = Account(
                      id: result.user!.uid,
                      name: nameController.text,
                      userId: userIdController.text,
                      description: descriptionController.text,
                      imagePath: imagePath,
                    );
                    var _result = await UserFirestore.setUser(newAccount);
                    Navigator.pop(context);
                  }
              } else {
                print('登録情報をすべて入力してください');
              }
            },
            child: const Text('アカウントを作成'))
          ]),
        ),
      ),
    );
  }
}