import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/Models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> user = [
    UserModel(id: 1, name: 'yacine', phone: '0262'),
    UserModel(id: 2, name: 'sara', phone: '0332'),
    UserModel(id: 3, name: 'youyou', phone: '08862'),
    UserModel(id: 4, name: 'yadsfdfe', phone: '0262'),
    UserModel(id: 5, name: 'lksdfj,n', phone: '0332'),
    UserModel(id: 6, name: 'sdqsdu', phone: '08862'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context, index) => buildUserItem(user[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: user.length),
      ),
    );
  }

  Widget buildUserItem(UserModel user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          child: Text(
            user.id.toString(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              user.phone,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
