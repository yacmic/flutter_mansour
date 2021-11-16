import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('First App'),
        elevation: 50,
        leading: const Icon(
          Icons.menu,
        ),
        actions: const [
          Icon(Icons.search),
          Icon(Icons.notification_important),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg'),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.black.withOpacity(0.5),
                        child: const Text(
                          'Flower',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
