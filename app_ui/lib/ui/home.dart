import 'package:flutter/material.dart';
import 'package:googleauth/utils/firebase_auth.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "demo user";
  String userEmail = "qwerty@googlw.com";
  String userImage = "";

  @override
  void initState() {
    super.initState();
    inputData();
  }

  sendUserDataToMySql(
      String userName, String userMail, String userImage) async {
    // print('function initiated');
    String url = 'http://192.168.43.216:3000/users';
    // Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"username": "$userName", "email": "$userMail", "profileImage": "$userImage"}';

    //print(json);
    Response response = await post(url,
        headers: {"Content-Type": "application/json"}, body: json);
    int statusCode = response.statusCode;
    String userSql = response.body;
    print(userSql);
    print(statusCode);
  }

  getUserData() async {
    String url = 'http://192.168.43.216:3000/users';
    Response response = await get(url);

    String jsonUserData = response.body;
    print(jsonUserData);
  }

  void inputData() async {
    final user = await AuthProvider().getUser();
    final uName = user.displayName;
    final uEmail = user.email;
    final uImage = user.photoUrl;
    //print(uImage);
    setState(() {
      userName = uName;
      userEmail = uEmail;
      userImage = uImage;
      // sendUserDataToMySql(userName, userEmail, userImage);
      getUserData();
    });

    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(userName),
            Text(userEmail),
            RaisedButton(
              child: Text("Log out"),
              onPressed: () {
                AuthProvider().logOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
