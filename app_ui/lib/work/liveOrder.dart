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

class LiveOrder extends StatefulWidget {
  @override
  _LiveOrderState createState() => _LiveOrderState();
}

class _LiveOrderState extends State<LiveOrder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'googleauth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Live Orders'),
            backgroundColor: Colors.teal,
          ),
          body: Container(
            child: Text("No Live Orders"),
          )),
    );
  }
}
