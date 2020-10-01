import 'package:flutter/material.dart';
import 'package:hims_mobile/reusables/color_converter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class CalendarSchedule extends StatefulWidget {
  @override
  _CalendarScheduleState createState() => _CalendarScheduleState();
}

class _CalendarScheduleState extends State<CalendarSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.only(top:5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [hex("#1A1CF8"), hex("#2575FC").withOpacity(1.0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                    ),
                  image: DecorationImage(image: AssetImage("images/screenshot.png"), fit: BoxFit.fill)
                ),
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title: Text('View Calendar', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    primary: true,
                    elevation: 0,
                    ),
                  body: SafeArea(
                          child: Container(
                          padding: EdgeInsets.only(top: 30, ),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                            ),
                          child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    child: SfCalendar(
                                      view: CalendarView.month,
                                      // timeSlotViewSettings: TimeSlotViewSettings(
                                      //                           startHour: 9,
                                      //                           endHour: 16,
                                      //                           nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
                                      // monthViewSettings: MonthViewSettings(showAgenda: true),
                                      dataSource: MeetingDataSource(_getDataSource()),
                                      monthViewSettings: MonthViewSettings(
                                                          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
                                                          ),
                                      
                                    ),
                                  ),
                         ),
                    ),
                  )
                )
              );
  }

  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}