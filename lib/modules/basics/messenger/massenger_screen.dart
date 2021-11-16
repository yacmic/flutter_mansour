import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MassengerScreen extends StatelessWidget {
  const MassengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 20,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/236x/7d/1a/3f/7d1a3f77eee9f34782c6f88e97a6c888--no-face-facebook-profile.jpg'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Chats',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              //margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Row(
                children: const [
                  Icon(Icons.search),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Search'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buildStoryItem(),
                itemCount: 10,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => buildChatItem(),
                itemCount: 10,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStoryItem() => Container(
        width: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Stack(
              children: const [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/236x/7d/1a/3f/7d1a3f77eee9f34782c6f88e97a6c888--no-face-facebook-profile.jpg'),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.green,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Yacine Abdelouahab',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );

  Widget buildChatItem() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Stack(
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/236x/7d/1a/3f/7d1a3f77eee9f34782c6f88e97a6c888--no-face-facebook-profile.jpg'),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.green,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Yacine Abdelouahab sssssssssssssssssssssssssssssssssssssssssssss',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'message lmqsfd dfhfgdh fgh fdg h fdgh fdgh  ',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('11:48 am')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
          ),
        ],
      );
}
