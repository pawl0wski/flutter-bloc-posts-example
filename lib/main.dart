import 'package:flutter/material.dart';

import 'post_page/post_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Posts",
      home: PostPage(),
    );
  }
}
