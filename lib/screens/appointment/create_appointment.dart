import 'package:flutter/material.dart';
import 'confirm_appointment.dart';

class CreateAppointment extends StatefulWidget {
  @override
  _CreateAppointmentState createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }
  @override
  Widget build(BuildContext context) {
    final fullname =  Padding(
                        padding: EdgeInsets.only(top: 20.0,),
                        child: TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: "Full Name", 
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)
                                  )
                                ),
                              )
                        );

    final phonenumber =  Padding(
                            padding: EdgeInsets.only(top: 20.0,),
                            child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: "Phone Number", 
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32.0)
                                      )
                                    ),
                                  )
                            );
    final card = Container(
                          height: 75.0,
                          width: 300.0,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black)],
                            border: Border(right: BorderSide(width: 3.0, color: hex("#B595E2")))
                          ),
                          
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // CircleAvatar(
                                //   backgroundImage: AssetImage("images/girl.png"),
                                //   radius: 40,
                                // ),
                                // SizedBox(width: 15,),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: <Widget>[
                                //       Text('Cardo Therapy', style: TextStyle(color: hex("#1A1CF8"), fontFamily: "Museo Sans", fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                                //       SizedBox(height: 5.0),
                                //       Text('April 5, 2014 7:24 AM', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                                //   ],
                                // ),
                                
                              ],
                            ),
                            ),
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
                      child: Center(
                        child: SingleChildScrollView(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 30, ),
                                width: MediaQuery.of(context).size.width * 1,
                                height: MediaQuery.of(context).size.height * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0 ),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Enter Children of Create Appointment
                                          Text('Create an appointment', style: TextStyle(fontSize: 14.0, color: hex("#4A4A4A"), fontWeight: FontWeight.w600 ),),
                                          fullname,
                                          phonenumber,
                                          SizedBox(height: 30.0,),
                                          card,
                                        ],
                                      ),
                                  ),
                                ),

                                // Flat Button
                                Material(
                                  color: hex("#1A1CF8"), 
                                  child: MaterialButton(
                                            onPressed: (){
                                              Navigator.push(context,  MaterialPageRoute(builder: (context) => ConfirmAppointment()));
                                            },
                                            height: 50,
                                            minWidth: MediaQuery.of(context).size.width * 1, 
                                            child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 14.0),),
                                          )
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