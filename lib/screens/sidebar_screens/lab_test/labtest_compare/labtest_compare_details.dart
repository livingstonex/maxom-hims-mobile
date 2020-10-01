import 'package:flutter/material.dart';
import '../../../../reusables/color_converter.dart';
import '../../../../reusables/cards/labtestcard.dart';
import '../../../../reusables/circle.dart';


class LabTestCompareDetails extends StatelessWidget {
  final String title;
  final data;

  const LabTestCompareDetails ({ Key key, this.title, this.data}): super(key: key);

  
  @override
  Widget build(BuildContext context) {
    print(data[0]['diagnosisTitle']);
    return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [hex("#1A1CF8"), hex("#2575FC").withOpacity(1.0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                    ),
                  image: DecorationImage(image: AssetImage("images/screenshot.png"), fit: BoxFit.fill)
                ),
                child: Scaffold(
                   appBar: AppBar(
                    title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    primary: true,
                    elevation: 0,
                    ),
                  extendBodyBehindAppBar: true,
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                          child: Container(
                          padding: EdgeInsets.only(top: 20, ),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                            ),
                          child: SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Content
                                          // Top Test Compare =========================================
                                         Center(
                                           child: Text(data[0]['diagnosisTitle'], style: TextStyle(color: hex('#4F4B4B'), fontSize: 14.0, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,),),
                                         ),

                                         SizedBox(height: 30,),

                                         Padding(
                                           padding: const EdgeInsets.only(right: 20.0),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.end,
                                             children: <Widget>[
                                                Circle(color: '#FB6262', title: 'Bad',),
                                             ],
                                           ),
                                         ),
                                         SizedBox(height: 20,),
                                          Padding(
                                           padding: const EdgeInsets.only(left: 40.0,),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                                  Text('Temperature', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal,),),
                                                  SizedBox(height: 10,),
                                                  Text('20 F', style: TextStyle(color: hex('#656567'), fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                  
                                                  SizedBox(height: 30,),
                                                  
                                                  Text('Pulse', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal,),),
                                                  SizedBox(height: 10,),
                                                  Text('20 F', style: TextStyle(color: hex('#656567'), fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),

                                                  SizedBox(height: 30,),
                                                  
                                                  Text('Weight', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal,),),
                                                  SizedBox(height: 10,),
                                                  Text('20 F', style: TextStyle(color: hex('#656567'), fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                  SizedBox(height: 20,),
                                                  
                                                  Divider(),
                                                  SizedBox(height: 30,),

                                                  // Botttom Test Compare ===============================
                                                  Center(
                                                    child: Text(data[1]['diagnosisTitle'], style: TextStyle(color: hex('#4F4B4B'), fontSize: 14.0, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,),),
                                                  ),

                                                  SizedBox(height: 10,),

                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 20.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                          Circle(color: '#FFD25B', title: 'Bad',),
                                                      ],
                                                    ),
                                                  ),
                                                
                                                  SizedBox(height: 20,),
                                                  Text('Temperature', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal,),),
                                                  SizedBox(height: 10,),
                                                  Text('20 F', style: TextStyle(color: hex('#656567'), fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                  
                                                  SizedBox(height: 30,),
                                                  
                                                  Text('Pulse', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal,),),
                                                  SizedBox(height: 10,),
                                                  Text('20 F', style: TextStyle(color: hex('#656567'), fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),

                                                  SizedBox(height: 30,),
                                                  
                                                  Text('Weight', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal,),),
                                                  SizedBox(height: 10,),
                                                  Text('20 F', style: TextStyle(color: hex('#656567'), fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),


                                             ],
                                           ),
                                         ),

                                        ],
                            ),
                                    ),
                                  ),
                         ),
                    ),
                  )
                )
              );
  }
}