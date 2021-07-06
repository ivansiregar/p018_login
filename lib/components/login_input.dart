import 'package:p018_login/constanta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputLogin extends StatelessWidget {
  InputLogin(
      {Key key,
      @required this.signin,
      @required this.loading,
      @required this.username,
      @required this.password,
      @required this.size,
      this.secure = false,
      @required this.hidePassword})
      : super(key: key);

  final TextEditingController username;
  final TextEditingController password;

  final bool secure;

  final bool loading;

  final Function signin;
  final Function hidePassword;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "E-COMMERCE",
                style: GoogleFonts.lato(
                    fontSize: 28,
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                    controller: username,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Color(0xFF666666),
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: GoogleFonts.lato(color: Color(0xff666666)),
                      hintText: "Email",
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                    showCursor: true,
                    controller: password,
                    obscureText: !secure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Color(0xFF666666),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: hidePassword,
                        child: Icon(
                          Icons.remove_red_eye,
                          color: secure ? colorPrimary : Color(0xFF777777),
                        ),
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: GoogleFonts.lato(color: Color(0xff666666)),
                      hintText: "Password",
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                    disabledColor: Colors.grey[300],
                    onPressed: loading ? null : signin,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: colorPrimary,
                    child: loading
                        ? CircularProgressIndicator()
                        : Text("Sign In",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
