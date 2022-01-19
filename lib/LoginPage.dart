import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Container(
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://media-exp1.licdn.com/dms/image/C4E03AQFOwGdbeMQrpw/profile-displayphoto-shrink_200_200/0/1624728048567?e=1645056000&v=beta&t=ef4Q3CSHZfP5SdAmSAWtXaSyDJL2_0H3YRSsbNhPDQQ",
              height: 50,
              ),
              SizedBox(
              height: 50,
            ),
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
                  loginNow();
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }

  Future<void> loginNow() async {
    var email = emailcontroller.text;
    var password = passwordcontroller.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("LoggedIn")));
    } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for that email.")));

    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password provided for that user.")));

    print('Wrong password provided for that user.');
  }
    } catch (e) {
      print(e);
    }
  }
}
