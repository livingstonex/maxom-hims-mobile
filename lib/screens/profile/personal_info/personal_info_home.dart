import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hims_mobile/handlers/helpers.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/personal_info_card.dart';
import './pages/profile_update.dart';
import './pages/contact_update.dart';
import './pages/nok_update.dart';

class PersonalInfoHome extends StatefulWidget {
  int id;
  PersonalInfoHome ({ Key key, this.id }): super(key: key);
  @override
  _PersonalInfoHomeState createState() => _PersonalInfoHomeState();
}

class _PersonalInfoHomeState extends State<PersonalInfoHome> {
  
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
                    title: Text('Personal Information', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                          padding: EdgeInsets.only(top: 50, ),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                            ),
                          child: Center(
                            child: SingleChildScrollView(
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // Content
                                            InkWell(
                                              child: PersonInfoCard(sideColor: "#B595E2",  title: "Profile Update",),
                                              onTap: (){ 
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdate(id: widget.id,) ));
                                                },
                                            ),
                                            SizedBox(height: 20,),
                                            InkWell(
                                              child: PersonInfoCard(sideColor: "#FF99DD", title: "Contact Information",),
                                              onTap: (){ 
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUpdate(id: widget.id,) ));
                                                },
                                            ),
                                            SizedBox(height: 20,),
                                             InkWell(
                                              child: PersonInfoCard(sideColor: "#F9D89D", title: "Next of Kin"),
                                              onTap: (){ 
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => NOKUpdate(id: widget.id,) ));
                                                },
                                            ),
                                          ],
                              ),
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