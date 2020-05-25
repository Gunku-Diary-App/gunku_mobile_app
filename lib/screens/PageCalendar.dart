import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gunku/components/ScaleRoute.dart';

import 'PageDiary.dart';
import 'PageHowToUse.dart';
import 'PageSettings.dart';

class PageCalendar extends StatefulWidget {
  @override
  _PageCalendarState createState() => _PageCalendarState();
}

class _PageCalendarState extends State<PageCalendar> {
  DateTime _currentDate = DateTime.now();
  //String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  //DateTime _targetDateTime = DateTime(2019, 2, 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select The Date",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            _myCalendar(),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _infoButton(),
                SizedBox(
                  width: 41,
                ),
                _settingsButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, ScaleRoute(page: PageHowToUse()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.questionCircle,
            size: 18,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "How To Use",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget _settingsButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, ScaleRoute(page: PageSettings()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.user,
            size: 18,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Settings",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget _myCalendar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          //this.setState(() => _currentDate = date);
          String clickDate = date.day.toString() + "." + date.month.toString() + "." + date.year.toString();
          Navigator.push(context, ScaleRoute(page: PageDiary(clickDate,date)));
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {},
        weekFormat: false,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false,
      ),
    );
  }
}
