import 'package:flutter/material.dart';
import '../color_converter.dart';
import 'package:intl/intl.dart';

class PersonCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String rightSubTitle;

  const PersonCard ({ Key key, this.imageUrl, this.title, this.subTitle, this.rightSubTitle }): super(key: key);
  @override
  _PersonCardState createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {

  _getDate(String date){
    var dt = DateTime.parse(date);
    var newDt = DateFormat.yMMMEd().format(dt);
    return newDt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
                child: Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width *   0.9,
                        margin: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black)],
                          border: Border(right: BorderSide(width: 3.0, color: hex("#7EB0EE")))
                        ),
                        
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                      widget.imageUrl != null ?  CircleAvatar(
                                                                    backgroundImage: AssetImage(widget.imageUrl),
                                                                    radius: 40,
                                                                  ) : SizedBox(),
                                      SizedBox(width: 15,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            widget.title != null ? Text(widget.title, style: TextStyle(color: hex("#1A1CF8"), fontFamily: "Museo Sans", fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),) : SizedBox(),
                                            SizedBox(height: 5.5),
                                            Text(widget.subTitle != null ? widget.subTitle : '', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),),
                                            // Text(widget.subTitle, style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                                        ],
                                      ),
                                          ],
                                ),
                              ),
                              
                            Text(widget.rightSubTitle != null ? _getDate(widget.rightSubTitle) : '', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                            ],
                          ),
                          ),
                      )
                    );
  }
}