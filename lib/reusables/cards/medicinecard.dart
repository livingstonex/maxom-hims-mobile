import 'package:flutter/material.dart';
import '../color_converter.dart';
import '../../handlers/helpers.dart';
import 'package:intl/intl.dart';

class MedicineCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  final String backgroundColor;
 

  const MedicineCard ({ Key key, this.title, this.subTitle, this.imageUrl, this.backgroundColor }): super(key: key);

  @override
  _MedicineCardState createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 79.0,
                    width: 117,
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: widget.backgroundColor != null ? hex(widget.backgroundColor) : hex("#F6F7FB"),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget.imageUrl != null ? Image.asset(widget.imageUrl) : SizedBox(),
                        SizedBox(height: 4,),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: widget.title != null ? Text(widget.title, style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 10.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),) : SizedBox(),
                          ),
                        SizedBox(height: 3,),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(widget.subTitle != null ? getTime(widget.subTitle) : '', style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 9.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                          ),
                      ],
                    ),
                  );
  }
}