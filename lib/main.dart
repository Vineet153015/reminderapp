import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(RemindersApp());
}

class RemindersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RemindersPage(),
    );
  }
}



