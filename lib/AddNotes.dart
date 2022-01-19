import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("notesdb");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Column(
        children: [
          Icon(Icons.notes),
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Enter Title"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(hintText: "Enter Desc"),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                savedataintoFirebase();
              },
              child: Text("Save"))
        ],
      ),
    );
  }

  savedataintoFirebase() async {
    var title = titleController.text;
    var desc = descController.text;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter title")));
    } else if (desc.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Description")));
    }
    //save data into firebase
    else {
      await ref.child("notes").child(title).set({
        "title": title,
        "desc": desc,
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Notes Saved")));
        Navigator.pop(context);
      });
    }
  }
}
