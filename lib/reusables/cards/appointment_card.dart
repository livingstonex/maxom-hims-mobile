import 'package:flutter/material.dart';
import '../color_converter.dart';
import 'package:hims_mobile/handlers/helpers.dart';

class AppointmentCard extends StatefulWidget {
  String notes;
  bool confirmed;
  String dateTime;

  AppointmentCard ({ Key key, this.notes, this.confirmed, this.dateTime }): super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
                          height: 100.0,
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black)],
                            border: Border(right: BorderSide(width: 3.0, color: hex("#7EB0EE")))
                          ),
                          
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage("images/girl.png"),
                                  radius: 40,
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                      widget.confirmed != null ? Text(widget.confirmed == true ? 'Confirmed' : 'Not Confirmed', style: TextStyle(color: hex("#1A1CF8"), fontFamily: "Museo Sans", fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),) : SizedBox(),
                                      SizedBox(height: 5.0),
                                      Text(widget.dateTime != null ? getDateTime(widget.dateTime) : 'No date referenced', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                                  ],
                                ),
                                SizedBox(width: 50),

                                ClipOval(
                                          // borderRadius: BorderRadius.circular(100.0),
                                          child: MaterialButton(
                                            disabledColor: Colors.blue[200],
                                            onPressed: () { },
                                            height: 10.0,
                                            // minWidth: MediaQuery.of(context).size * 0.5,
                                            color: hex("#236DD0"),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('view',
                                                            style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                            ),
                                              ],
                                            ),
                                            ),
                                        ),
                                                  
                                
                              ],
                            ),
                            ),
                        );
  }
}
// 'April 5, 2014 7:24 AM'