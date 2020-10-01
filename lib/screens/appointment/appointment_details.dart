import 'package:flutter/material.dart';
import 'package:hims_mobile/screens/appointment/calendar/calendar_schedule.dart';
import '../../reusables/color_converter.dart';
import 'package:hims_mobile/handlers/helpers.dart';
// import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:slimy_card/slimy_card.dart';
import 'load_calendars.dart';

class AppointmentDetails extends StatefulWidget {
  var data;
  AppointmentDetails({Key key, this.data}): super(key: key);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  DeviceCalendarPlugin _deviceCalendarPlugin;
  List<Calendar> _calendars;
  Calendar _selectedCalendar;

  AppointmentDetails(){
    _deviceCalendarPlugin = new DeviceCalendarPlugin();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // retrieveCalendars();
  }

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
                    title: Text('Appoitnment Detail', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                                    child: Padding(
                                          padding: EdgeInsets.only(left: 5, top: 30, right: 5, bottom: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                                // Text('Appointment Notes:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 20),),
                                                // Text('${widget.data['notes']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300], fontSize: 14)),
                                                // SizedBox(height: 20,),
                                                // Text('Confirmed:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 20),),
                                                // Text('${widget.data['confirmed']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300], fontSize: 14)),
                                                // SizedBox(height: 20,),
                                                // Text('Time:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 20),),
                                                // Text('${getDateTime(widget.data['dateTime'])}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300], fontSize: 14)),
                                                // SizedBox(height: 40,),
                                                //  SizedBox(height: 35,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 1,
                                                  height: MediaQuery.of(context).size.height * 0.9,
                                                  child: ListView(
                                                        children: <Widget>[
                                                          SlimyCard(
                                                            color: Colors.indigo[400],
                                                            width: 400,
                                                            topCardHeight: 250,
                                                            // bottomCardHeight: 200,
                                                            borderRadius: 15,
                                                            topCardWidget: topCardWidget("images/mayowa_pix.png"),
                                                            bottomCardWidget: bottomCardWidget(),
                                                            slimeEnabled: true,
                                                          ),

                                                           SizedBox(height: 10,),
                                                           ClipRRect(
                                                            borderRadius: BorderRadius.circular(22.0),
                                                            child: MaterialButton(
                                                              disabledColor: Colors.indigo[400],
                                                              onPressed: () { 
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarSchedule() ));
                                                                // retrieveCalendars();
                                                                // addCalendars();
                                                              // print(event.description);
                                                              },
                                                              height: 47.0,
                                                              // minWidth: MediaQuery.of(context).size * 0.5,
                                                              color: Colors.indigo[600],
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text('View on Calender',
                                                                              style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                                              ),
                                                                ],
                                                              ),
                                                              ),
                                                            ),

                                                            SizedBox(height: 20,),
                                                        ],
                                                      ),
                                                ),
    
                                            ]
                                          )
                                    ),
                                  ),
                         ),
                    ),
                  )
                )
              );
  }

// Top Card Widget
  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text('Appointment',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
               Text('Confirmed:',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),

                  SizedBox(width: 5),

                  Text('${widget.data['confirmed']}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

// Bottom Card Widget
    Widget bottomCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          Text('Notes:',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),

          Text("${widget.data['notes']}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

          SizedBox(height: 10,),
          Text("Date:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 5,),
          Text('${getDateTime(widget.data['dateTime'])}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[300], fontSize: 14)),
          
      ],
    );
  }
}