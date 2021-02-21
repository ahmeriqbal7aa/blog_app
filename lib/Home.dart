import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: cancel_subscriptions
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('BlogPost');
  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        snapshot = dataSnapshot.docs;
      });
    });
  }

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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.purple, Colors.red]),
              ),
              accountName: Text('Ahmer Iqbal'),
              accountEmail: Text('ahmer5253@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Text('A'),
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.cake, color: Colors.purple),
              title: Text('First Page'),
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.redAccent),
              title: Text('Second Page'),
            ),
            ListTile(
              leading: Icon(Icons.cached, color: Colors.orange),
              title: Text('Third Page'),
            ),
            ListTile(
              leading: Icon(Icons.menu, color: Colors.green),
              title: Text('Fourth Page'),
            ),
            ListTile(
              leading: Icon(Icons.cake, color: Colors.purple),
              title: Text('First Page'),
            ),
            ListTile(
              leading: Icon(Icons.cake, color: Colors.purple),
              title: Text('First Page'),
            ),
            Divider(height: 10.0, color: Colors.black),
            ListTile(
              trailing: Icon(Icons.close, color: Colors.red),
              title: Text('Close'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
