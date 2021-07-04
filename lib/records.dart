import 'package:flutter/material.dart';

class MyRecords extends StatelessWidget {
  final String title, value;

  MyRecords({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        )
      ],
    );
  }
}
