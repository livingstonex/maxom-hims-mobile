import 'package:flutter/material.dart';
import './color_converter.dart';

class Circle extends StatelessWidget {
  final String color;
  final String title;

  const Circle ({ Key key, this.color, this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 30,
              width: 80,
              // color: Colors.purpleAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color != null ? hex(color) : Colors.blueAccent
                      ),
                    ),
                    // SizedBox(width: 5,),
                    title != null ? Text(title, style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 12.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),) : SizedBox()
                ],
              ),
          );
  }
}
