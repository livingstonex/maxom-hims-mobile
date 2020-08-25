import 'package:flutter/material.dart';
import 'appointment.dart';
import 'package:hims_mobile/tab/tab.dart';

class ConfirmAppointment extends StatefulWidget {
  @override
  _ConfirmAppointmentState createState() => _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends State<ConfirmAppointment> {
   Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }
  @override
  Widget build(BuildContext context) {
    final like_circle = Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: hex("#F4F5FE"),
                              borderRadius: BorderRadius.circular(100.0)
                            ),
                            child: Center(child: Image.asset("images/like.png")),
                          );
    return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [hex("#1A1CF8"), hex("#2575FC").withOpacity(1.0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                    ),
                  image: DecorationImage(image: AssetImage("images/screenshot.png"), fit: BoxFit.fill)
                ),
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Create Appointment', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    primary: true,
                    elevation: 0,
                    ),
                  extendBodyBehindAppBar: true,
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                      child: Container(
                              padding: EdgeInsets.only(top: 30, ),
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                                ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    like_circle,
                                    SizedBox(height: 20.0,),
                                    Text('Your Appointment have been created', style: TextStyle(color: hex("#4A4A4A"), fontSize: 14.0, fontStyle: FontStyle.normal, fontFamily: 'Museo Sans'),),
                                    SizedBox(height: 40.0,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 40, right: 20),
                                      child: Text('You book appointment with Doctor Mayowa Adegunwa on March 31, 2019 at 9:00 AM', textAlign: TextAlign.center, style: TextStyle(color: hex("#4A4A4A"), fontSize: 14.0, fontStyle: FontStyle.normal, fontFamily: 'Museo Sans', fontWeight: FontWeight.w300), ),
                                      ),


                                      // Reminder Row
                                    Padding(
                                      padding: EdgeInsets.only(left: 20, top:40, right:20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          RaisedButton(
                                                    onPressed: () {},
                                                    color: hex("#1A1CF8"),
                                                    shape: StadiumBorder(),
                                                    child: Text("Set Reminder", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                                  ),

                                          
                                          OutlineButton(
                                                    onPressed: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainTabView()));
                                                    }, 
                                                    borderSide: BorderSide(
                                                      color: hex("#979797"),
                                                      style: BorderStyle.solid,
                                                      width: 1
                                                    ),
                                                    shape: StadiumBorder(),
                                                    child: Text("Go to Home"),
                                                  ),
                                        ],
                                      ),
                                      )
                                  ],
                                ),
                              )
                              ),
                    
                  )
                )
              );
  }
}