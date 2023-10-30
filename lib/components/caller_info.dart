import 'package:flutter/material.dart';

class LastCallerInfo extends StatelessWidget {
  final String title;
  final String content;

  const LastCallerInfo({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(content),

      ],
    );
  }
}
