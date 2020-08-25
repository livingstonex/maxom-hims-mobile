import 'package:flutter/material.dart';
import '../color_converter.dart';

class PersonInfoCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String rightSubTitle;
  final String sideColor;

  const PersonInfoCard ({ Key key, this.imageUrl, this.title, this.subTitle, this.rightSubTitle, this.sideColor }): super(key: key);
  @override
  _PersonInfoCardState createState() => _PersonInfoCardState();
}

class _PersonInfoCardState extends State<PersonInfoCard> {
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
                          border: Border(right: BorderSide(width: 3.0, color: widget.sideColor != null ? hex(widget.sideColor) : hex("#7EB0EE")))
                        ),
                        
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                            widget.title != null ? Text(widget.title, style: TextStyle(color: Colors.blueGrey, fontFamily: "Museo Sans", fontSize: 15.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),) : SizedBox(),
                                            SizedBox(height: 5.5),
                                            // widget.subTitle != null ? Text(widget.subTitle, style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)  : SizedBox(),
                                            // Text(widget.subTitle, style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                                        ],
                                      ),
                                          ],
                                ),
                              ),
                              
                            // widget.rightSubTitle != null ? Text(widget.rightSubTitle, style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),) : SizedBox()
                            ],
                          ),
                          ),
                      )
                    );
  }
}