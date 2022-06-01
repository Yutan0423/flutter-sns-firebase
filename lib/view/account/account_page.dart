import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_firebase/model/account.dart';
import 'package:flutter_sns_firebase/model/post.dart';
import 'package:flutter_sns_firebase/utils/authentication.dart';
import 'package:flutter_sns_firebase/view/timeline/post_page.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
                  color: Colors.deepPurple.withOpacity(0.3),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                foregroundImage: NetworkImage(myAccount.imagePath),
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(myAccount.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text('@${myAccount.userId}', style: const TextStyle(color: Colors.grey)),
                                ],
                              )
                            ],
                          ),
                          OutlinedButton(onPressed: () {}, child: Text('編集'))
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Text(myAccount.description)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Colors.blue, width: 3))
                  ),
                  child: const Text('投稿', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
                Expanded(child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: postList.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  })
                ))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
          },
          child: const Icon(Icons.chat_bubble_outline),
        ),
      ),
    );
  }
}