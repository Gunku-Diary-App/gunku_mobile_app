import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gunku/components/ScaleRoute.dart';
import 'package:gunku/models/Diary.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'PageCalendar.dart';
import 'PageConfigure.dart';

class PageWelcome extends StatefulWidget {
  @override
  _PageWelcomeState createState() => _PageWelcomeState();
}

class _PageWelcomeState extends State<PageWelcome> {
  @override
  void initState() {
    super.initState();
    // Bu sayfada yukleme ayarla ve yolla
    _openDb().then((val) {
      //Navigator.push(context, ScaleRoute(page: PageCalendar()));
    });

    /*
    // Bu sayfada yukleme ayarla ve yolla
    Timer timer = new Timer(new Duration(seconds: 5), () {
      Navigator.push(context, ScaleRoute(page: PageCalendar()));
    });
    */
  }

  Future<bool> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    var _box = await Hive.openBox('box');
    if (_box.get('name') == null) {
      Navigator.pushReplacementNamed(context, '/configurePage');
    } else {
      if(_box.get('loginbool') != null){
        if(_box.get('loginbool') == true){
          Navigator.pushReplacementNamed(context, '/loginPage');
        }else{
          Navigator.pushReplacementNamed(context, '/calendarPage');
        }
      }else{
        Navigator.pushReplacementNamed(context, '/calendarPage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JumpingText(
              'Welcome',
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(
              height: 20,
            ),
            JumpingDotsProgressIndicator(
              fontSize: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
