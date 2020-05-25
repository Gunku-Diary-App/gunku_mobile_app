import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class PageSettings extends StatefulWidget {
  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  bool _value1 = false;
  bool _value2 = true;

  void _value1Changed(bool value) async {
    _changeBool(value).then((val){
    setState(() {
      _value1 = value;
    });
    });
  }
  void _value2Changed(bool value) async => setState(() => _value2 = value);


  String name = "";
  String password = "";

  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();

  Future<bool> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    var _box = await Hive.openBox('box');
    if (_box.get("name") != null) {
      name = _box.get("name");
    }
    if (_box.get("password") != null) {
      password = _box.get("password");
    }
    if (_box.get("loginbool") != null) {
      _value1 = _box.get("loginbool");
    }
    setState(() {
      nameCtrl.text = name;
      passwordCtrl.text = password;
      _value1 = _value1;
      print(_value1);
    });
  }

  Future<bool> _changeBool(bool state) async {
    var _box = await Hive.openBox('box');
    if(state == true){
    _box.put("loginbool", true);
    }else{
    _box.put("loginbool", false);
    }
    return true;
  }

  final snackBar1 = SnackBar(
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

  final snackBar2 = SnackBar(
    content: Text('Your information has been successfully changed !'),
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
  void initState() {
    _openDb().then((val) {
      print("name : " + name);
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (context) {
        return ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Settings",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login to the application with a password",
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  width: 10,
                ),
                Checkbox(value: _value1, onChanged: _value1Changed),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Diaries are Encrypted and Saved",
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  width: 10,
                ),
                Checkbox(value: _value2, onChanged: _value2Changed),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Change Your Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: nameCtrl,
                          maxLength: 10,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          /* Bu alanda kayit islemleri yapilmaktadir */
                          if (nameCtrl.text.length <= 2) {
                            Scaffold.of(context).showSnackBar(snackBar1);
                          } else {
                            var _box = await Hive.openBox('box');
                            _box.put("name", nameCtrl.text);
                            Scaffold.of(context).showSnackBar(snackBar2);
                          }
                        },
                        color: Colors.blueAccent,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Change Your Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: passwordCtrl,
                          maxLength: 4,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          /* Bu alanda kayit islemleri yapilmaktadir */
                          if (passwordCtrl.text.length <= 3) {
                            Scaffold.of(context).showSnackBar(snackBar1);
                          } else {
                            var _box = await Hive.openBox('box');
                            _box.put("password", passwordCtrl.text);
                            Scaffold.of(context).showSnackBar(snackBar2);
                          }
                        },
                        color: Colors.blueAccent,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Contact: contact@berkekurnaz.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21),
                      )
                    ],
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15))),
            ),
          ],
        );
      },
    ));
  }
}
