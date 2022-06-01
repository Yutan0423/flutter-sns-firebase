import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id;
  String name;
  String imagePath;
  String description;
  String userId;
  DateTime? createdTime;
  DateTime? updatedTime;

  Account(
    {
      this.id = '',
      this.name = '',
      this.imagePath = '',
      this.description = '',
      this.userId = '',
      this.createdTime,
      this.updatedTime,
    }
  );
}