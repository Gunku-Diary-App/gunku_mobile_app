import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController passwordCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Login To Gunku",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextField(
                    controller: passwordCtrl,
                    keyboardType: TextInputType.numberWithOptions(),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        )),
                  ),
                ),
                Container(
                  height: 75,
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: RaisedButton(
                      onPressed: () async {
                        var _box = await Hive.openBox('box');
                        if (_box.get("password") != null) {
                          if(_box.get("password") ==passwordCtrl.text){
                            Navigator.pushReplacementNamed(context, '/calendarPage');
                          }else{
                              _wrongPasswordAlert(context);
                          }
                        }
                      },
                      color: Colors.black,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onAlertButtonPressed(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("Forgot Password !"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Forgot Password",
      desc: "Unfortunately, you cannot login when you forget the password.",
      buttons: [
        DialogButton(
          child: Text(
            "Okey",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  
  _wrongPasswordAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Wrong Password",
      desc: "You cannot log in until you have entered the correct password.",
      buttons: [
        DialogButton(
          child: Text(
            "Okey",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

}
