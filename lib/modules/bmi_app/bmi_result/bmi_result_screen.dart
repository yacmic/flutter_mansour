import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  final int? age;
  final double? result;
  final bool? isMale;

  const BmiResultScreen({Key? key, this.age, this.result, this.isMale})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMale! ? 'Male' : 'Female'} ',
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Result : ${result!.round()} ',
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Age : $age ',
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
