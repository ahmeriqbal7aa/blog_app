import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Blog App'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint('search'),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => debugPrint('add'),
          )
        ],
      ),
    );
  }
}
