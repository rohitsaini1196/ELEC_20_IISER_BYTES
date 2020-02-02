import 'package:flutter/material.dart';
import 'package:googleauth/utils/firebase_auth.dart';
//import 'package:flutter/services.dart';
//import 'package:googleauth/work/addWork.dart';
import 'bottomBar.dart';
import 'work.dart';
import 'package:http/http.dart' as http;

class WorkDetail extends StatefulWidget {
  WorkDetail(this.work);
  final Work work;

  @override
  _WorkDetailState createState() => _WorkDetailState();
}

class _WorkDetailState extends State<WorkDetail> {
  String doerEmailId;

  _postAceeptUser(String userMail, int workId) async {
    String url = 'http://192.168.43.216:3000/accept';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{ "workId": $workId, "userMail" : "$userMail"}';

    print("PostAcceptUser" + json);
    final response = await http.post(url, headers: headers, body: json);

    int statusCode = response.statusCode;

    if (statusCode == 200) {
      print('YOU ACCEPTED THIS WORK SUCCESS');
    } else {
      print('sOME error while acceting this order');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserEmailandName();
  }

  _getUserEmailandName() async {
    final user = await AuthProvider().getUser();
    // final uName = user.displayName;
    String uEmail = user.email;
    setState(() {
      doerEmailId = uEmail;
    });
    //print(userEmailId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'Favorit',
        ),
      ),
      body: Container(
          child: Center(
        child: Column(
          children: <Widget>[
            Divider(
              height: 5.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Work id no." + widget.work.idDb.toString()),
            Divider(
              height: 4.0,
            ),
            Text("Work Description" + widget.work.workDes),
            Divider(
              height: 4.0,
            ),
            Text("Kaam giver" + widget.work.idUsersGiver),
            Divider(
              height: 4.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Pickup Point " + widget.work.pickup),
            Divider(
              height: 4.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Drop Point : " + widget.work.dropPoint),
            Divider(
              height: 4.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Garuda Offerd : " + widget.work.garuda),
            Divider(
              height: 4.0,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('daba de mujhe'),
              onPressed: () {
                _postAceeptUser(doerEmailId, widget.work.idDb);
                print("I want to do waork, where I = $doerEmailId");
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
      bottomNavigationBar: BottomBar(),
    );
  }
}
