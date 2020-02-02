import 'package:flutter/material.dart';
import 'package:googleauth/ui/login.dart';
import 'package:googleauth/utils/firebase_auth.dart';
//import 'package:flutter/services.dart';
import 'package:googleauth/work/addWork.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'bottomBar.dart';

class ProfilePageDesign extends StatefulWidget {
  @override
  _ProfilePageDesignState createState() => _ProfilePageDesignState();
}

class _ProfilePageDesignState extends State<ProfilePageDesign> {
  String userName = "demo user";
  String userEmail = "qwerty@googlw.com";
  String userImage = "";
  int garuda = 0;
  bool _loading = true;

  Future _getUserData() async {
    final userDetils = 'http://192.168.43.216:3000/users/$userEmail';
    final response2 = await http.get(userDetils);

    if (response2.statusCode == 200) {
      Map jsonResponse2 = json.decode(response2.body);
      setState(() {
        garuda = jsonResponse2['garuda'];
        _loading = false;
      });
    } else {
      print('status code is not 200');
    }
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

      _getUserData();
    });
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading == true) {
      return CircularProgressIndicator(
        backgroundColor: Colors.teal,
      );
    }
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 5.0,
          centerTitle: true,
          title: Text('Favorit',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 25.0,
                  color: Color(0xFFCDCDCD))),
        ),

        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('$userImage'),
                  radius: 60,
                  backgroundColor: Colors.black,
                ),
                SizedBox(height: 40),
                Text(
                  'NAME',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Text(
                  '$userName',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Garuda Coins',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.album),
                    Text(
                      '$garuda',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Weekly Rank',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Text(
                  '13',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'EMAIL',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Text(
                  '$userEmail',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 150),
                RaisedButton(
                  onPressed: () {
                    // 'signOutGoogle'();
                    AuthProvider().logOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                  },
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                )
              ],
            ),
          ),
        ),

        // floatingActionButton: FloatingActionButton(onPressed: () {},
        // backgroundColor: Color(0xFFF17532),
        // child: Icon(Icons.add_circle_outline),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostWork()));
          },
          backgroundColor: Colors.teal,
          child: Icon(Icons.work),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
