import 'package:flutter/material.dart';
import '../../reusables/color_converter.dart';
import 'doctors_report.dart';

class FavoriteDoctor extends StatefulWidget {
  @override
  _FavoriteDoctorState createState() => _FavoriteDoctorState();
}

class _FavoriteDoctorState extends State<FavoriteDoctor> {
  @override
  Widget build(BuildContext context) {

    final FavoriteDoctorCard =  Container(
                                      height: 140.0,
                                      // 180.0
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      padding: EdgeInsets.only(left: 15, top:10, right: 10, bottom: 15),
                                      decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(blurRadius: 10.0, spreadRadius: 1, offset: Offset(0, 5), color: Color.fromRGBO(0, 0, 0, 0.1))],
                                        color: Colors.white
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              // Doctor Image
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: AssetImage("images/girl.png"),
                                              ),

                                              // Green Pill
                                              Container(
                                                height: 11.0,
                                                width: 26.0,
                                                decoration: BoxDecoration(
                                                  color: hex("#0CD5A4"),
                                                  borderRadius: BorderRadius.circular(30.0),
                                                ),
                                                child: FlatButton.icon(
                                                  onPressed: null, 
                                                  icon: Icon(Icons.star, color: hex("#FFC107"),), 
                                                  label: Text('5', style: TextStyle(color: Colors.white, fontSize: 6.0, fontFamily: "Noto Sans Syloti Nagri"),)),
                                              )
                                            ],
                                          ),

                                          // Text Headers
                                          SizedBox(height: 10,),
                                          Text('Eduardo Simmons', style: TextStyle(color: hex("#1A1CF8"), fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                          SizedBox(height: 5,),
                                          Text('Consultant', style: TextStyle(color: hex("#000000"), fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                          SizedBox(height:5,),
                                          Text('Available', style: TextStyle(color: hex("#0CD4A4"), fontSize: 10.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                        ],
                                      ),
                                    );
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
                    title: Text('Favorite Doctors', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Wrap(
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (contex) => DoctorsReport()));
                                                },
                                                child: FavoriteDoctorCard),
                                                InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (contex) => DoctorsReport()));
                                                },
                                                child: FavoriteDoctorCard),
                                              FavoriteDoctorCard,
                                              FavoriteDoctorCard,
                                              FavoriteDoctorCard,
                                              FavoriteDoctorCard,
                                              FavoriteDoctorCard,
                                              
                                            ],
                                          ),
                                        )
                                      ),
                                      )
                                    ),
                        )
                      )
                    );
  }
}