import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:googleauth/ui/login.dart';

import 'package:googleauth/utils/firebase_auth.dart';
import 'package:googleauth/work/addWork.dart';
import 'package:googleauth/work/bottomBar.dart';
import 'package:googleauth/work/workDetail.dart';
import 'package:http/http.dart' as http;
import 'work.dart';

class AcceptedOrder extends StatefulWidget {
  @override
  _AcceptedOrderState createState() => _AcceptedOrderState();
}

class _AcceptedOrderState extends State<AcceptedOrder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'googleauth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Accepted Orders'),
            backgroundColor: Colors.teal,
          ),
          body: Container(
            child: Text("No accepted Orders"),
          )),
    );
  }
}
