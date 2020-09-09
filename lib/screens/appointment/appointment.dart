import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hims_mobile/handlers/helpers.dart';
import 'package:hims_mobile/handlers/requests.dart';
import 'package:table_calendar/table_calendar.dart';
import 'create_appointment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../reusables/cards/appointment_card.dart';
import './appointment_details.dart';
import '../../reusables/shimmers/appointment_shimmer.dart';


class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }
  CalendarController _controller;
  var _appointments;
 

  @override
  void initState() { 
    super.initState();
    _controller = CalendarController();
    _appointments = _getAppointments();
    
  }

  // Get all Appointments Function
  _getAppointments() async{
        var _token = await getToken();
        var _encodedUser = await getUserData();
        var _decodedUser = jsonDecode(_encodedUser);
        var _userId = _decodedUser['id'];
        // var _user = jsonDecode(await getUserData())['id'];
        
        // Define remote url

        var _url = "api/user/patientappointment/" + _userId.toString();
        print(_url);
        HttpService service = HttpService();
  
          var res = await service.getRequest(_url, _token);
          print(res);
          return res;
          // List<Data> appointmentData = [];
          // for (var u in res) {
          //   Data singleData = Data(u['id'], u['dateTime'],  u['notes'], u['confirmed'],);
          //   appointmentData.add(singleData);
          // }

          // print(appointmentData);
          // return appointmentData;
      }

      Future<void> _refresh() async{
        setState(() {
          _appointments = _getAppointments();
        });
      }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: _refresh,
      displacement: 100.0,
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [hex("#1A1CF8"), hex("#2575FC").withOpacity(1.0)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
            ),
          image: DecorationImage(image: AssetImage("images/screenshot.png"), fit: BoxFit.fill)
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Container to contain Date
                    Container(
                      padding: EdgeInsets.all( 10.0),
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: SingleChildScrollView(
                                            child: TableCalendar(
                                                      calendarController: _controller,
                                                      calendarStyle: CalendarStyle(
                                                        contentPadding: EdgeInsets.only(bottom:40.0, left: 20.0, right: 20.0),
                                                        selectedColor: Colors.white,
                                                        selectedStyle: TextStyle(color: hex("2D78D9"), fontSize: 14.0),
                                                        weekdayStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                                                        weekendStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                                                        outsideWeekendStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                                                        outsideStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                                                        ),
                                                        headerStyle: HeaderStyle(
                                                          centerHeaderTitle: true,
                                                          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                                                          // formatButtonVisible: false,
                                                          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
                                                          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white,),
                                                          formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                                                          formatButtonDecoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(50.0),
                                                            ),
                                                          formatButtonShowsNext: false,
                                                          ),
                                                        daysOfWeekStyle: DaysOfWeekStyle(
                                                          weekdayStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                                                          weekendStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                                                        ),
                                                        initialCalendarFormat: CalendarFormat.month,
                                                        formatAnimation: FormatAnimation.scale,
                                                        onDaySelected: (date, dynamic){
                                                          // Set State Here
                                                          print(date);
                                                        },
                                                      ),
                      ),
                    ),

                    // Align Container to contain list of appointments
                    Align(
                      alignment: Alignment.bottomCenter,
                        child: Container(
                                padding: EdgeInsets.only(top: 30, ),
                                width: MediaQuery.of(context).size.width * 1,
                                height: MediaQuery.of(context).size.height * 0.50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                                  ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(height: 7,),
                                                // Display cards for the list [List Card]
                                                // InkWell(
                                                //   onTap: (){
                                                //     Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAppointment()));
                                                //   },
                                                //   child: card
                                                //   ),
                                                // card,

                                                // if(snapshot.data != null){
                                                //                     if(snapshot.data.length != 0) {
                                                //                           return ListView.builder(
                                                //                               itemCount: snapshot.data.length,
                                                //                               scrollDirection: Axis.vertical,
                                                //                               shrinkWrap: true,
                                                //                               itemBuilder: (BuildContext context, int index){
                                                //                                 return InkWell(
                                                //                                               child: AppointmentCard(),
                                                //                                               onTap: (){
                                                //                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAppointment()));
                                                //                                             });
                                                //                               },
                                                //                             );
                                                //                       }else{
                                                //                         return Text('No Appointments');
                                                //                       }
                                                //                 }else{ return Text('No data returned, please reload'); }

                                                // return snapshot.data != null ? ListView.builder(
                                                //                               itemCount: snapshot.data.length,
                                                //                               scrollDirection: Axis.vertical,
                                                //                               shrinkWrap: true,
                                                //                               itemBuilder: (BuildContext context, int index){
                                                //                                 return InkWell(
                                                //                                               child: AppointmentCard(),
                                                //                                               onTap: (){
                                                //                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAppointment()));
                                                //                                             });
                                                //                                           },
                                                //                                         )
                                                //                               : Container(child: Text('No Appointments'),);

                                           // SetUp a Future Builder
                                                    FutureBuilder(
                                                        // initialData: {},
                                                        future: _appointments,
                                                        builder: (BuildContext context, snapshot){
                                                          // try {
                                                            if(snapshot.connectionState == ConnectionState.done){
                                                              if(snapshot.hasError){
                                                                return Container( child: Text('Error Loading, Refresh!'), );
                                                              } else {
                                                                  if(snapshot.data != null){
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data.length,
                                                                              scrollDirection: Axis.vertical,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (BuildContext context, int index){
                                                                                return InkWell(
                                                                                              child: AppointmentCard(confirmed: snapshot.data[index]['confirmed'], dateTime: snapshot.data[index]['dateTime'],),
                                                                                              onTap: (){
                                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetails(data: snapshot.data[index],)));
                                                                                            });
                                                                              },
                                                                            );
                                                                }else{ return Text('No appointments'); }
                                                                
                                                              }
                                                            } else {
                                                              return Container(
                                                                        height: MediaQuery.of(context).size.height * 0.4,
                                                                        child: AppointmentShimmer()
                                                                        // SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                                        );
                                                            }
                                                          // } catch (e) {
                                                          //     print(e);
                                                          //     return Text('Network Error!');
                                                          // }
                                                        } 
                                                      ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ),
                    )
                  ],
                )
                // Text('Appointment Home', style: TextStyle(color: Colors.white, fontSize: 25.0),),
                ),
            
          )
        )
      ),
    );
  }
}

class Data {
  final int id;
  final String dateTime;
  final String notes;
  final bool confirmed; 

  Data(this.id, this.dateTime, this.notes, this.confirmed);
}