import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sns_firebase/model/account.dart';
import 'package:flutter_sns_firebase/model/post.dart';
import 'package:flutter_sns_firebase/view/timeline/post_page.dart';
import 'package:intl/intl.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  Account myAccount = Account(
    id: '1',
    name: 'Flutterラボ',
    description: 'こんばんは',
    userId: 'flutter_labo',
    imagePath: 'https://pbs.twimg.com/profile_images/1264933336826273792/SL1eldQT_400x400.jpg',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now()
  );

  List<Post> postList = [
    Post(
      id: '1',
      content: '初めまして',
      accountId: '1',
      createdTime: DateTime.now(),
    ),
    Post(
      id: '2',
      content: 'こんちゃ',
      accountId: '1',
      createdTime: DateTime.now(),
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('タイムライン', style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: index == 0 ? const Border(
                top: BorderSide(color: Colors.grey, width: 0),
                bottom: BorderSide(color: Colors.grey, width: 0),
              ) : const Border(bottom: BorderSide(color: Colors.grey, width: 0),)
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  foregroundImage: NetworkImage(myAccount.imagePath),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(myAccount.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('@${myAccount.userId}'),
                              ],
                            ),
                            Text(DateFormat('yyyy/M/d').format(postList[index].createdTime!))
                          ],
                        ),
                        Text(postList[index].content),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}