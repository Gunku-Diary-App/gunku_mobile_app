import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gunku/components/ScaleRoute.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'PageCalendar.dart';

class PageDiary extends StatefulWidget {
  String date;
  DateTime dateTime;

  PageDiary(this.date, this.dateTime);

  @override
  _PageDiaryState createState() => _PageDiaryState();
}

class _PageDiaryState extends State<PageDiary> {
  String todayDate = DateTime.now().day.toString() +
      "." +
      DateTime.now().month.toString() +
      "." +
      DateTime.now().year.toString();

  DateTime convertDateTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day); // It is today..
  DateTime testing = DateTime(2019, 2, 3);

  String content = "";

  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = new TextEditingController();
  TextEditingController textReadController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _openDb().then((val) {
      setState(() {
        textController.text = content;
        if (content.length > 3) {
          textReadController.text = content;
        } else {
          textReadController.text =
              "You have not written any diary on this date.";
        }
      });
    });
  }

  Future<bool> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    var _box = await Hive.openBox('box');
    if (_box.get(widget.date) != null) {
      content = _box.get(widget.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showPageForDate(),
    );
  }
  // 2020 > 2019 ise true
  // convertDateTime.isAfter(testing)

  /* Duruma gore acilacak sayfa buradan belirlenecek */
  Widget _showPageForDate() {
    if (widget.date == todayDate) {
      return _widgetWriteDiary();
    } else if (convertDateTime.isAfter(widget.dateTime) == true) {
      return _widgetReadDiary();
    } else if (convertDateTime.isAfter(widget.dateTime) == false) {
      return _widgetFutureDiary();
    } else {
      return Text("Error");
    }
  }

  /* Eger Yazimis Gunluk Yoksa ve Tarih Bugunse bu sayfa acilacak */
  Widget _widgetWriteDiary() {
    return ListView(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          "Write a Diary",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Form(
              key: _formKey,
              child: TextFormField(
                controller: textController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.5, color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
                maxLength: 2000,
                maxLines: 15,
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: OutlineButton(
            focusColor: Colors.grey,
            highlightedBorderColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.save,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Save",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            borderSide: BorderSide(color: Colors.black, width: 2),
            onPressed: () async {
              var _box = await Hive.openBox('box');
              if (_box.get(widget.date) == null) {
                _box.put(widget.date, textController.text);
              } else {
                _box.put(widget.date, textController.text);
              }
              Navigator.push(context, ScaleRoute(page: PageCalendar()));
            },
          ),
        ),
      ],
    );
  }

  /* Eget Yazılmıs gunluk varsa ve tarih gecmis ise bu sayfa acilacak */
  Widget _widgetReadDiary() {
    return ListView(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          "Read a Diary",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          "${widget.date}",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Form(
              child: TextFormField(
            controller: textReadController,
            readOnly: true,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.5, color: Colors.black)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black))),
            maxLength: 2000,
            maxLines: 15,
          )),
        ),
      ],
    );
  }

  /* Tarih gelecek ise bu acilir */
  Widget _widgetFutureDiary() {
    return ListView(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          "Gunku App",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 150,
        ),
        Text(
          "The date you selected will come in the future",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "You can write diary only when that day comes to this field.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: OutlineButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.backward,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Back To Calendar Page",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            borderSide: BorderSide(color: Colors.black, width: 2),
            onPressed: () {
              Navigator.push(context, ScaleRoute(page: PageCalendar()));
            },
          ),
        ),
      ],
    );
  }
}
