import 'package:flutter/material.dart';
import 'package:gunku/components/ScaleRoute.dart';
import 'package:hive/hive.dart';

import 'PageCalendar.dart';

class PageConfigure extends StatefulWidget {
  @override
  _PageConfigureState createState() => _PageConfigureState();
}

class _PageConfigureState extends State<PageConfigure> {
  TextEditingController txtNameCtrl = new TextEditingController();
  TextEditingController txtPassCtrl = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldState;

  final snackBar = SnackBar(
    content: Text('Please fill all the fields !'),
    action: SnackBarAction(
      label: 'Okey',
      textColor: Colors.white,
      disabledTextColor: Colors.white,
      onPressed: () {
        // on pressed method
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        body: Builder(
          builder: (context){
            return ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Welcome To\nGunku App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "First of all, Can I learn your name?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: TextField(
                controller: txtNameCtrl,
                maxLength: 10,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                )),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "And now can you set a Password ?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: TextField(
                controller: txtPassCtrl,
                keyboardType: TextInputType.numberWithOptions(),
                maxLength: 4,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "* You can change your name and password later in the settings section.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: RaisedButton(
                onPressed: () async {
                  /* Bu alanda kayit islemleri yapilmaktadir */
                  if (txtNameCtrl.text.length <= 2 ||
                      txtPassCtrl.text.length <= 3) {
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else {
                    var _box = await Hive.openBox('box');
                    _box.put("name", txtNameCtrl.text);
                    _box.put("password", txtPassCtrl.text);
                    Navigator.pushReplacementNamed(context, '/calendarPage');
                  }
                },
                color: Colors.black,
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              ),
            ),
          ],
        );
          },
        )
        );
  }
}
