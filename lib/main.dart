import 'package:p018_login/screens/home.dart';
import 'package:p018_login/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String islogin = sharedPreferences.getString("bio");
  bool loggedIn = false;
  if (islogin != null) {
    loggedIn = true;
  }
  runApp(MyApp(isLogin: loggedIn));
}

class MyApp extends StatelessWidget {
  MyApp({this.isLogin = false});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(
        seconds: 3,
        title: Text(
          "ECOMMERCE",
          style: GoogleFonts.lato(
              letterSpacing: 3, fontSize: 27, fontWeight: FontWeight.bold),
        ),
        loadingText: Text("Loading..."),
        navigateAfterSeconds: isLogin ? HomeScreens() : LoginScreens(),
      ),
    );
  }
}
