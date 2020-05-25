import 'package:flutter/material.dart';
import 'package:gunku/screens/PageConfigure.dart';
import 'package:gunku/screens/PageLogin.dart';
import 'package:gunku/screens/PageWelcome.dart';

import 'screens/PageCalendar.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        backgroundColor: Color.fromRGBO(236, 240, 241,1.0),
        fontFamily: "Nunito",
        accentColor: Colors.black,
      ),
    routes: {
      "/": (context) => PageWelcome(),
      "/configurePage": (context) => PageConfigure(),
      "/loginPage": (context) => PageLogin(),
      "/calendarPage": (context) => PageCalendar(),
    },
  ));
}