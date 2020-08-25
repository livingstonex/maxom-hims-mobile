import 'package:flutter/material.dart';
import '../color_converter.dart';

class LabTestCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String rightSubTitle;
  final String circleColor;
  final String bgColor;

  const LabTestCard ({ Key key, this.imageUrl, this.title, this.subTitle, this.rightSubTitle, this.circleColor, this.bgColor }): super(key: key);
  @override
  _LabTestCardState createState() => _LabTestCardState();
}

class _LabTestCardState extends State<LabTestCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
                child: Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width *   0.9,
                        margin: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: widget.bgColor == "" ? Colors.white : hex(widget.bgColor),
                          boxShadow: [BoxShadow(color: Colors.black)],
                          border: Border(right: BorderSide(width: 3.0, color: hex("#7EB0EE")))
                        ),
                        
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                      widget.imageUrl != null ?  Image.asset(widget.imageUrl) : SizedBox(),
                                      SizedBox(width: 15,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            widget.title != null ? Text(widget.title, style: TextStyle(color: hex("#1A1CF8"), fontFamily: "Museo Sans", fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),) : SizedBox(),
                                            SizedBox(height: 5.5),
                                            widget.subTitle != null ? Text(widget.subTitle, style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)  : SizedBox(),
                                            // Text(widget.subTitle, style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                                        ],
                                      ),
                                          ],
                                ),
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                 Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.circleColor != null ? hex(widget.circleColor) : Colors.blueAccent
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  widget.rightSubTitle != null ? Text(widget.rightSubTitle, style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),) : SizedBox(),
                              ],
                            ),
                            
                            ],
                          ),
                          ),
                      )
                    );
  }
}