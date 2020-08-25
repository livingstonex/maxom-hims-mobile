import 'package:flutter/material.dart';
import '../color_converter.dart';

class ExaminationCard extends StatefulWidget {
  final String title;
  const ExaminationCard({ Key key, this.title,}): super(key: key);

  @override
  _ExaminationCardState createState() => _ExaminationCardState();
}

class _ExaminationCardState extends State<ExaminationCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
                child: Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(bottom: BorderSide(width: 1.0, color: hex("#C4C4C4")))
                        ),
                        
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                widget.title != null ? Text(widget.title, style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 18.0, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),) : SizedBox()
                            ],
                          ),
                          ),
                      )
                    );
  }
}