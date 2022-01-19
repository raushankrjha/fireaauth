// ignore_for_file: unused_local_variable

import 'package:fireauth/AddNotes.dart';
import 'package:fireauth/Notes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Notes> notesdata = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("notesdb");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdatafromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
      ),
      body: _bodyWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNotes()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bodyWidget() {
    return ListView.builder(
        itemCount: notesdata.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            child: ListTile(
              leading: Icon(Icons.notes_rounded),
              title: Text(notesdata[index].title),
              subtitle: Text(notesdata[index].desc),
              trailing: Icon(Icons.edit),
            ),
          );
        });
  }

  Future<void> fetchdatafromFirebase() async {
    // Get the data once
    DatabaseEvent event = await ref.child("notes").once();

// Print the data of the snapshot
    print(event.snapshot.value);
    print(event.snapshot.value);

    var keys = event.snapshot.children; //key
    var data = event.snapshot.value as Map; //des:"jj","title":"hh"

    notesdata.clear();

    for (var key in data.keys) {
      Notes notes = Notes(data![key]['title'], data[key]['desc']);
      setState(() {
        notesdata.add(notes);
      });
    }
    print(notesdata.length);
  }
}
