import 'package:flutter/material.dart';
//import 'package:googleauth/work/workListView.dart';
import 'package:http/http.dart' as http;
import 'bottomBar.dart';
import 'package:googleauth/utils/firebase_auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new PostWork()
      },
      home: new PostWork(),
    );
  }
}

class PostWork extends StatefulWidget {
  @override
  _PostWorkState createState() => _PostWorkState();
}

class _PostWorkState extends State<PostWork> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String userEmailId;

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
      userEmailId = uEmail;
    });
    print(userEmailId);
  }

  _makePostRequest(String giverId, String workDes, String pickup,
      String dropPoint, String remarks, int phoneNo) async {
    String url = 'http://192.168.43.216:3000/';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{ "giverId":" $giverId", "workDes":" $workDes", "pickup": "$pickup", "dropPoint":" $dropPoint", "remarks": "$remarks", "phoneNo":"$phoneNo"}';
    // make POST request
    print(json);
    final response = await http.post(url, headers: headers, body: json);

    int statusCode = response.statusCode;

    if (statusCode == 200) {
      print('data saved to db successfully');
    } else {
      print('you suck so much');
    }
  }

  TextEditingController pickupCon = TextEditingController();
  TextEditingController dropCon = TextEditingController();
  TextEditingController workCon = TextEditingController();
  TextEditingController garudaCon = TextEditingController();
  TextEditingController remarkCon = TextEditingController();
  TextEditingController mobCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0.0,
        centerTitle: true,
        title: Text('googleauth',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 25.0,
                color: Color(0xFFCDCDCD))),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.teal)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                    child: Text(
                      'Add Work.',
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(150.0, 10.0, 0.0, 0.0),
                  //   child: Text(
                  //     'Work',
                  //     style: TextStyle(
                  //         fontSize: 50.0,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.teal),
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: pickupCon,
                      decoration: InputDecoration(
                          labelText: 'From',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: dropCon,
                      decoration: InputDecoration(
                          labelText: 'Your Location',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: workCon,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: garudaCon,
                      decoration: InputDecoration(
                          labelText: 'Garuda Offered',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: remarkCon,
                      decoration: InputDecoration(
                          labelText: 'Additional Remarks',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: mobCon,
                      decoration: InputDecoration(
                          labelText: 'Contact Number',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 80.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.teal,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              // print(int.parse(mobCon.text));

                              if (workCon.text != "" &&
                                  pickupCon.text != "" &&
                                  dropCon.text != "") {
                                print('ready to post gg');
                                print("shit shit shit" + "$userEmailId");
                                _makePostRequest(
                                    "$userEmailId",
                                    workCon.text,
                                    pickupCon.text,
                                    dropCon.text,
                                    remarkCon.text,
                                    int.parse(mobCon.text));
                                // print('popup hua');
                                Navigator.of(context).pop();
                              } else {
                                print('bakchodi hia');
                              }
                            },
                            child: Center(
                              child: Container(
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                  ],
                )),
          ]),
      bottomNavigationBar: BottomBar(),
    );
  }
}
