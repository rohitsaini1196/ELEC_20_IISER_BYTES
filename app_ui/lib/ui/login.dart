import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/utils/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController _emailController;
  // TextEditingController _passwordController;

  // @override
  // void initState() {
  //   super.initState();
  //   _emailController = TextEditingController(text: "");
  //   _passwordController = TextEditingController(text: "");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  Container(
                    height: 250,
                    child: HeaderLogo(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Image.asset(
                      'assets/image/bottom_bg.png',
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Social(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Social extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 60),
        Text("Login with Google",
            style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.teal, letterSpacing: 1.2),
                fontSize: 23,
                fontWeight: FontWeight.w400)),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 80,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.red[600],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                MaterialCommunityIcons.google,
                color: Colors.white,
              ),
              onPressed: () async {
                bool res = await AuthProvider().loginWithGoogle();
                if (!res) print("error logging in with google");
              },
              iconSize: 50.0,
              alignment: Alignment.center,
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          right: 0,
          top: 75,
          child: SizedBox(
            child: Image.asset('assets/image/bg1.png'),
            width: 250,
            height: 200,
          ),
        ),
        Positioned(
          child: Text("FavorIt.",
              style: GoogleFonts.lato(
                  textStyle:
                      TextStyle(color: Color(0xFFF17532), letterSpacing: 0.5),
                  fontSize: 24,
                  fontWeight: FontWeight.w500)),
          top: 42,
          right: 155.0,
        ),
        Positioned(
          top: 30,
          left: 0,
          child: Image.asset('assets/image/logo_11.png'),
        ),
      ],
    );
  }
}
