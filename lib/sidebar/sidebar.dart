import 'dart:convert';

import 'package:flutter/material.dart';
import '../reusables/color_converter.dart';
// Vitals Page
import '../screens/sidebar_screens/vitals/vitals.dart';
// Medical History
import '../screens/sidebar_screens/medical_history/medical_history_home.dart';
// Prescriptions
import '../screens/sidebar_screens/prescriptions/prescription.dart';
// Lab Tests
import '../screens/sidebar_screens/lab_test/labtest_home.dart';
// Lab Test Compare
import '../screens/sidebar_screens/lab_test/labtest_compare/labtest_compare.dart';
// Diagnosis
import '../screens/sidebar_screens/diagnosis/diagnosis_home.dart';
// Bills
import '../screens/sidebar_screens/bills/top_tab_bar/bills_tabs.dart';
// Logout function
import '../handlers/helpers.dart';
// Import SignIn Page
import '../screens/auth/login.dart';


class SideNavDrawer extends StatefulWidget {
  @override
  _SideNavDrawerState createState() => _SideNavDrawerState();
}

class _SideNavDrawerState extends State<SideNavDrawer> {
  var firstName;
  var lastName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

   _getUser() async{
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _firstName = _decodedUser['firstname'];
    var _lastName = _decodedUser['lastname'];

    print(_firstName);

    setState(() {
      firstName = _firstName;
      lastName = _lastName;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Drawer(
                  child: Container(
                      decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [hex("#6A11CB"), hex("#2575FC").withOpacity(1.0)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight
                        ),
                      image: DecorationImage(image: AssetImage("images/sidebar_screen_shot.png"), fit: BoxFit.fill)
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Image.asset('images/avatar.png'),
                                SizedBox(height: 5,),
                                Text('${lastName} ${firstName}', style: TextStyle(color: hex('#FDFAFA'), fontFamily: "Museo Sans", fontSize: 14.0, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),),
                                SizedBox(height: 3,),
                                Text('D324543', style: TextStyle(color: hex('#FDFAFA'), fontFamily: "Museo Sans", fontSize: 9.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: hex('#FDFAFA'), height: 0,),

                        // List Tiles
                        ListTile(
                          title: Text('Vital Signs', style: TextStyle(color: hex('#FDFAFA'), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w500),),
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => Vitals()))},
                        ),
                        Divider(color: hex('#FDFAFA'), height: 0,),
                        ListTile(
                          title: Text('Medical History', style: TextStyle(color: hex('#FDFAFA'), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w500),),
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalHistoryHome())) },
                        ),
                        Divider(color: hex('#FDFAFA'), height: 0,),
                        ListTile(
                          title: Text('Lab Results', style: TextStyle(color: hex('#FDFAFA'), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w500),),
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => LabTestCompare() )) },
                        ),
                        Divider(color: hex('#FDFAFA'), height: 0,),
                        ListTile(
                          title: Text('Diagnosis', style: TextStyle(color: hex('#FDFAFA'), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w500),),
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => Diagnoses() )) },
                        ),
                        Divider(color: hex('#FDFAFA'), height: 0,),
                        ListTile(
                          title: Text('Prescriptions', style: TextStyle(color: hex('#FDFAFA'), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w500),),
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => Prescriptions())) },
                        ),
                        Divider(color: hex('#FDFAFA'), height: 0,),
                        ListTile(
                          title: Text('Bills', style: TextStyle(color: hex('#FDFAFA'), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w500),),
                          onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => BillsTabs())) },
                        ),
                        Divider(color: hex('#FDFAFA'), height: 0,),
                        ListTile(
                          title: Text('Log Out', style: TextStyle(color: hex('#FDFAFA'), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w500),),
                          onTap: () {
                            logOut();
                            Navigator.pushAndRemoveUntil(
                              context, 
                              MaterialPageRoute(builder: (BuildContext context) => Login(), ),
                              (route) => false,
                              );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}