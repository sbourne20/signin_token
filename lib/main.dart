import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'service/auth3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Auth3Base>(
        create: (context) => Auth3(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));

    /*return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );*/
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImlhdCI6MTYxNjkzNzc4NCwiZXhwIjoxNjE2OTQxMzg0LCJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay14YmFjdUBnYXJhcGluLWYzNWVmLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwic3ViIjoiZmlyZWJhc2UtYWRtaW5zZGsteGJhY3VAZ2FyYXBpbi1mMzVlZi5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInVpZCI6IlZFMjNhN2UzNWJlM2YwZDNkZDM4ZjQ1ZjZiMzNmNjBiOWIifQ.Y4KP8dbqrarOoxZl6lSQy9CaowLNFdhesL-cmzf-5X9pyY_LgdKiPo4dTBbdKliLhmCGlo5AcF-iTGJ0oAGEUbly1keykKl8EdsT0aKKdmjDVRQIDfdRJ2jvjeqHYBhWNqzgNZtA554dE9aIHbYHawfwy4AhDAbSSuWR4ZkmBNBR6Veoox_7CIKJZWwik3Z2afQnaJpTslGnkUAhJCqPZLFj4D-s6YVEi2l0DylbND5QKF3Z-dMk6bAg6-KtNjy-Eg5_at4PO9zreyMrEPiQHAvJhgIe86Xdk0bF25ISbp9kctd_H4OJrS__hbt02p_hKuoBIKdwxoJ5LJwIcCuzqw";

  @override
  Widget build(BuildContext context) {
    final auth3 = Provider.of<Auth3Base>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  Firebase.initializeApp();
                },
                child: Text("Init")),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithCustomToken(token)
                      .then((value) => print(value.user));

                  //auth3.signInWithToken(token: token);
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
