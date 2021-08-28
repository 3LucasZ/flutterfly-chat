import 'package:flutter/material.dart';
import 'chat.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameTextController = TextEditingController();

  void login(ctx, username) {
    Navigator.push(
      ctx,
      new MaterialPageRoute(builder: (ctx) => new ChatPage(username: username)),
    );
  }

  @override
  void dispose() {
    nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2, // 20%
              child: Container(),
            ),
            Expanded(
              flex: 6, // 60%
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: nameTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          login(context, nameTextController.text);
                        },
                        child: Icon(Icons.send),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2, // 20%
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
