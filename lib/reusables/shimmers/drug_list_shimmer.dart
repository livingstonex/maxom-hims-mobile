import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../color_converter.dart';


class DrugListhimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   var cont_width =  MediaQuery.of(context).size.width * 0.65;

    return Shimmer.fromColors(
                baseColor: hex("#F6F7FB"),
                highlightColor: Colors.white,
                child: Container(
                    // height: 200,
                    // width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                              height: 79.0,
                              width: 117,
                              margin: EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: hex("#F6F7FB")
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Image.asset("images/drug.png"),
                                  SizedBox(height: 4,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text('Omega 3 - 2 pills', style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 10.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                    ),
                                  SizedBox(height: 3,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text('1:00pm', style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 9.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                                    ),
                                ],
                              ),
                            )
                      ],
                    )
                  ),
        );
  }
}