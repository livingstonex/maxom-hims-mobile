import 'package:flutter/material.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/personcard.dart';
import '../../../handlers/requests.dart';
import '../../../handlers/helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VitalDetails extends StatefulWidget {
  final String title;
  final String vital_id;
  var data;

  VitalDetails({ Key key, this.title, this.vital_id, this.data }): super(key: key);

  @override
  _VitalDetailsState createState() => _VitalDetailsState();
}

class _VitalDetailsState extends State<VitalDetails> {
  // Method definitions
  // getSingleVital() async{
  //   var _token = await getToken();
  //   var _url = 'api/doctor/vital/' + widget.vital_id;
  //   HttpService service = HttpService();
  //   try {
  //     var res = await service.getRequest(_url, _token); 
  //     print(res);
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
                    title: Text(widget.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                          padding: EdgeInsets.only(top: 30, ),
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
                                          // Vitals Row
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                // Left Vital
                                                Container(
                                                  padding: EdgeInsets.only(right: 60),
                                                  decoration: BoxDecoration(
                                                  border: Border(right: BorderSide(width: 1.0, color: hex('#D7D7D7'))),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text('Temperature', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                      SizedBox(height: 10,),
                                                      Text('${widget.data.temperature} ${widget.data.temperatureUnit}', style: TextStyle(color: hex('#656567'), fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                    
                                                      SizedBox(height: 30,),

                                                      Text('Pulse', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                      SizedBox(height: 10,),
                                                      Text('${widget.data.pulse}', style: TextStyle(color: hex('#656567'), fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                   
                                                      SizedBox(height: 30,),

                                                      Text('Weight', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                      SizedBox(height: 10,),
                                                      Text('${widget.data.weight} ${widget.data.weightUnit}', style: TextStyle(color: hex('#656567'), fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                    ],
                                                  ),
                                                ),

                                                // Right Vital
                                                Container(
                                                  padding: EdgeInsets.only(left: 60),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: <Widget>[
                                                      Text('Blood Pressure', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                      SizedBox(height: 10,),
                                                      Text('20 F', style: TextStyle(color: hex('#656567'), fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                    
                                                      SizedBox(height: 30,),

                                                      Text('Respiratory Rate', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                      SizedBox(height: 10,),
                                                      Text('${widget.data.respiratory}', style: TextStyle(color: hex('#656567'), fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                   
                                                      SizedBox(height: 30,),

                                                      Text('Height', style: TextStyle(color: hex('#B4B4B4'), fontSize: 11, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                      SizedBox(height: 10,),
                                                      Text('${widget.data.height} ${widget.data.heightUnit}', style: TextStyle(color: hex('#656567'), fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 30,),
                                            Padding(
                                              padding: EdgeInsets.only(left: 30, right: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                    Text('Others', style: TextStyle(color: hex('#B4B4B4'), fontFamily: "Museo Sans", fontSize: 11, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),),
                                                    SizedBox(height: 10,),
                                                    Text('${widget.data.others}', 
                                                          style: TextStyle(color: hex('#C4C4C4'), fontFamily: "Museo Sans", fontSize: 12, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),),
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 30,),
                                            // Person Card Display
                                            PersonCard(imageUrl: "images/booked_appointment_image.png", title: 'June 2, 2020', subTitle: 'Nurse Titi',)  

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