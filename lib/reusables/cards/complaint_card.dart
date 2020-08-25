import 'package:flutter/material.dart';
import '../color_converter.dart';
import 'package:intl/intl.dart';


class ComplaintCard extends StatefulWidget {
  final String text;
  final String doctor;
  final String createdAt;

  const ComplaintCard ({ Key key, this.text, this.createdAt, this.doctor}): super(key: key);
  @override
  _ComplaintCardState createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {

_getDate(String date){
  var dt = DateTime.parse(date);
  var newDt = DateFormat.yMMMEd().format(dt);
  return newDt;
}

@override
Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    width: MediaQuery.of(context).size.width * 0.7,
    decoration: BoxDecoration(
      border: Border(left: BorderSide(width: 3.0, color: hex("#7EB0EE"),))
    ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      // Content
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(widget.text != null ? widget.text : 'No details entered.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: hex('#C4C4C4'), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal, )),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Doctor:',
                                    style: TextStyle(color: hex('#C4C4C4'), fontSize: 12, fontWeight: FontWeight.w900, fontFamily: "Museo Sans", fontStyle: FontStyle.normal)),

                                Text(widget.doctor != null ? widget.doctor : 'No Doctor Name',
                                    style: TextStyle(color: hex('#C4C4C4'), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Created At',
                                    style: TextStyle(color: hex('#C4C4C4'), fontSize: 12, fontWeight: FontWeight.w900, fontFamily: "Museo Sans", fontStyle: FontStyle.normal)),

                                Text(widget.createdAt != null ? _getDate(widget.createdAt) : 'No date entered',
                                    style: TextStyle(color: hex('#C4C4C4'), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      // PersonCard(imageUrl: "images/booked_appointment_image.png", title: "Dr. Somto", subTitle: "June 2",)
                    ],
                  ),
  );
  }
}