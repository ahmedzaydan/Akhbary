import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "Welcome to my news application.\n"
          "this app contains many features.\n"
          "such as add to favorites, read lists",
          maxLines: 4,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
