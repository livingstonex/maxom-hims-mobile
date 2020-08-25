import 'package:flutter/material.dart';
import '../color_converter.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ChartCard extends StatefulWidget {
  final String backgroundColor;
  final String backgroundColorOpacity;
  final String headerText;
  final String headerSubText;
  final String rightHeaderNumber;
  final String rightHeaderNumberColor;
  final String rightHeaderNumberUnit;
  final List<double> graphData;
  final List<double> bpLowerData;
  final String lineColor;

  const ChartCard ({ Key key, this.backgroundColor, this.backgroundColorOpacity, this.headerText, this.headerSubText, this.rightHeaderNumber, this.rightHeaderNumberColor, this.rightHeaderNumberUnit, this.graphData, this.bpLowerData, this.lineColor}): super(key: key);
  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  var graphData;
  var bpLowerData;
  // var graphData = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 104.0,
                    // 180.0
                    width: MediaQuery.of(context).size.width * 0.44,
                    decoration: BoxDecoration(
                      color: hex(widget.backgroundColor).withOpacity((widget.backgroundColorOpacity != "") ? double.parse(widget.backgroundColorOpacity) : 1.0),
                      borderRadius: BorderRadius.circular(6.0)
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Top Text Row for Heart Rate
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Heart Rate Container
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(widget.headerText, style: TextStyle(color: hex("#4F4B4B"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                  Text(widget.headerSubText, style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 8.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                ],
                              ),
                            ),

                            // 184 Per Mins - Container
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(widget.rightHeaderNumber, style: TextStyle(color: hex(widget.rightHeaderNumberColor), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                  SizedBox(width: 5,),
                                  Text(widget.rightHeaderNumberUnit, style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 6.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        // Graph Here
                       widget.graphData == null ? SpinKitWave(size: 20.0, color: hex("#2575FC"),)  : 
                          Expanded(
                                child: widget.graphData.length > 1 ? 
                                    Sparkline(
                                      data: widget.graphData,
                                      // widget.data != null ? data:widget.data : SizedBox(),
                                      lineColor: widget.lineColor != null ? hex(widget.lineColor) : Colors.purpleAccent,
                                      ) 
                                    : Text('Sorry, no vitals found'),
                            )
                      ],
                    ),
                  );
  }
}