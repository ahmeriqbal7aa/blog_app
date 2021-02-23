import 'package:blog_app/PostDetailsPage.dart';
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

  // TODO Pass Data Method
  passData(DocumentSnapshot snap) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PostDetails(snapshot: snap)));
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
                gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.redAccent]),
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
      body: snapshot == null
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10.0,
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Text(snapshot[index].data()['title'][0]),
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        SizedBox(width: 10.0),
                        Container(
                          width: 210.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Text(
                                  snapshot[index].data()['title'],
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.green,
                                  ),
                                ),
                                onTap: () {
                                  // pass each and every index data
                                  passData(snapshot[index]);
                                },
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                snapshot[index].data()['content'],
                                maxLines: 2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
