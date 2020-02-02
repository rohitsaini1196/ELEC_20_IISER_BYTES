import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:googleauth/ui/login.dart';

import 'package:googleauth/utils/firebase_auth.dart';
import 'package:googleauth/work/acceptedOrder.dart';
import 'package:googleauth/work/addWork.dart';
import 'package:googleauth/work/bottomBar.dart';
import 'package:googleauth/work/workDetail.dart';
import 'package:http/http.dart' as http;
import 'liveOrder.dart';
import 'work.dart';

class WorkListView extends StatefulWidget {
  @override
  _WorkListViewState createState() => _WorkListViewState();
}

class _WorkListViewState extends State<WorkListView> {
  String userName = "demo user";
  String userEmail = "qwerty@googlw.com";
  String userImage = "";
  int garuda = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    inputData();
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
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      print('is loading function workung');
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("List of work"),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
          elevation: 10.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(userName),
                accountEmail: Text(userEmail),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(userImage),
                  backgroundColor: Colors.transparent,
                ),
                decoration: BoxDecoration(color: Colors.teal),
              ),
              ListTile(
                leading: Icon(MaterialCommunityIcons.coin),
                title: Text("$garuda"),
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(MaterialCommunityIcons.timer_sand),
                title: Text("Live Order"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LiveOrder()),
                  );
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.check_circle),
                title: Text("Accepted Order"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AcceptedOrder()),
                  );
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text("Leaderboard"),
                onTap: () {
                  print('Leaderboard');
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () {
                  print('Logout');
                  AuthProvider().logOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                },
              ),
              Divider(
                height: 2.0,
              ),
            ],
          )),
      body: Container(
        child: FutureBuilder<List<Work>>(
          future: _fetchWorks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Work> data = snapshot.data;
              return _jobsListView(data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
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
    );
  }

  Future<List<Work>> _fetchWorks() async {
    final jobsListAPIUrl = 'http://192.168.43.216:3000/des';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((work) => new Work.fromJson(work)).toList();
    } else {
      // throw Exception('Failed to load works from API');
      print('mai madarchod hu');
    }
  }

  Future _getUserData() async {
    final userDetils = 'http://192.168.43.216:3000/users/$userEmail';
    final response2 = await http.get(userDetils);

    // print("im getting user daATA - KESHAEV");
    if (response2.statusCode == 200) {
      Map jsonResponse2 = json.decode(response2.body);
      print(jsonResponse2["email"]);
      setState(() {
        garuda = jsonResponse2['garuda'];
      });
    } else if (response2.statusCode == 404) {
      print("posting new user");
      postUserNew(userName, userEmail, userImage);
    } else {
      print('user db me nhi mila');
      //  throw Exception('Failed to load user from API');
    }
  }

  Future postUserNew(
      String userName, String userEmail, String userImage) async {
    final url = 'http://192.168.43.216:3000/users';
    String newUserJson =
        '{"username": "$userName", "email": "$userEmail", "profileImage": "$userImage"}';

    print(" mai hu DOremon" + newUserJson);
    final response3 = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: newUserJson);
    int statusCode = response3.statusCode;
    String userSql = response3.body;
    print(userSql);
    print(statusCode);
    if (response3.statusCode == 200) {
      await _getUserData();
    } else {
      throw Exception('User submisson failed');
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  top: 10.0,
                  right: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Image(
                            image: NetworkImage(""),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data[index].workDes,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              child: Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  Text(
                                    data[index].pickup,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    " -",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    data[index].dropPoint,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    data[index].timePosted,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              print(data[index].timePosted);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkDetail(data[index])));
            },
          );
        });
  }
}
