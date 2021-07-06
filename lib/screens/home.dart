import 'dart:convert';

import 'package:p018_login/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  String email = '';
  String id = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = json.decode(sharedPreferences.getString("bio"));
    setState(() {
      id = data['id_member'];
      email = data['nameofmember'];
    });
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Keluar Akun"),
            content: Text("Apakah anda yakin ingin keluar akun?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Iya"),
                onPressed: () {
                  sharedPreferences.clear();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreens()));
                },
              ),
              FlatButton(
                child: Text("Tidak"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen", style: GoogleFonts.lato()),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.power_settings_new), onPressed: logout)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "ID : " + id,
                style: GoogleFonts.lato(fontSize: 25),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                email,
                style: GoogleFonts.lato(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
