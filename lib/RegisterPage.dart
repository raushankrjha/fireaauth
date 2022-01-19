import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireAuth"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: emailcontroller,
            decoration: InputDecoration(
                hintText: "Enter Email", prefixIcon: Icon(Icons.email)),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: true,
            controller: passwordcontroller,
            decoration: InputDecoration(
                hintText: "Enter Password",
                prefixIcon: Icon(Icons.remove_red_eye)),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                registernow();
              },
              child: Text("Register"))
        ],
      ),
    );
  }

  Future<void> registernow() async {
    var email = emailcontroller.text;
    var password = passwordcontroller.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
