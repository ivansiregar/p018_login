import 'dart:convert';

import 'package:p018_login/components/login_input.dart';
import 'package:p018_login/components/register_here.dart';
import 'package:p018_login/constanta.dart';
import 'package:p018_login/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreens extends StatefulWidget {
  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool loading = false;
  bool hidePass = false;

  void signin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    var body = new Map<String, dynamic>();
    body['x1'] = _email.text;
    body['x2'] = _password.text;

    try {
      http.Response response = await http.post(baseUrl + loginUrl, body: body);
      Map<String, dynamic> bodyResponse = json.decode(response.body);
      if (bodyResponse['success'] == 1) {
        sharedPreferences.setString(
            "bio", json.encode(bodyResponse['islogged'][0]).toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreens()));
      } else {
        final snackbar = SnackBar(
            content: Text(bodyResponse['message']),
            action: SnackBarAction(label: "CLOSE", onPressed: hideSnackBar));
        _scaffoldKey.currentState.showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(
          content: Text("Terjadi Kesalahan Pada Server HTTPS " + e.toString()),
          action: SnackBarAction(label: "CLOSE", onPressed: hideSnackBar));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }

    setState(() {
      loading = false;
    });
  }

  void hideSnackBar() {
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            InputLogin(
              signin: signin,
              size: size,
              username: _email,
              password: _password,
              loading: loading,
              hidePassword: () => setState(() {
                hidePass = !hidePass;
              }),
              secure: hidePass,
            ),
            RegisterHere(size: size),
          ],
        ));
  }
}
