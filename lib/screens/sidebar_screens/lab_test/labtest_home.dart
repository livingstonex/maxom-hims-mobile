import 'package:flutter/material.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/labtestcard.dart';
import '../../../reusables/circle.dart';
import './labtest_result.dart';

class LabTestHome extends StatefulWidget {
  @override
  _LabTestHomeState createState() => _LabTestHomeState();
}

class _LabTestHomeState extends State<LabTestHome> {
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
                    title: Text('Lab Tests', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                          child: SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          // Content
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: <Widget>[
                                              Circle(color: '#119745', title: 'Good',),
                                              Circle(color: '##FFD25B', title: 'Moderate',),
                                              Circle(color: '#FB6262', title: 'Bad',),
                                           ],
                                         ),
                                         SizedBox(height: 20,),

                                        //  Row of the Forms
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: <Widget>[
                                            //  Filter Result Form
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0.0),
                                                child: Container(
                                                  height: 50,
                                                  width: 200,
                                                  child: TextFormField(
                                                      keyboardType: TextInputType.text,
                                                      autofocus: false,
                                                      decoration: InputDecoration(
                                                        hintText: "Filter Result", 
                                                        contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(32.0)
                                                        )
                                                      )
                                                    )
                                                  ),
                                              ),

                                            // Sort Form
                                            Padding(
                                                padding: const EdgeInsets.only(left: 0.1),
                                                child: Container(
                                                  height: 50,
                                                  width: 100,
                                                  child: TextFormField(
                                                      keyboardType: TextInputType.text,
                                                      autofocus: false,
                                                      decoration: InputDecoration(
                                                        hintText: "Sort", 
                                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(32.0)
                                                        )
                                                      )
                                                    )
                                                  ),
                                              ),

                                           ],
                                         ),
                                         SizedBox(height: 20,),
                                         InkWell(
                                           child: LabTestCard(imageUrl: 'images/syringe2.png', subTitle: 'Full Blood Count', rightSubTitle: 'June 12', circleColor: "#119745",),
                                           onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => LabTestResult(title: 'Full Blood Count',))); },
                                           ),
                                        //  LabTestCard(imageUrl: 'images/syringe2.png', subTitle: 'Malaria Parasite', rightSubTitle: 'June 12', circleColor: "#FB6262",),
                                        //  LabTestCard(imageUrl: 'images/syringe2.png', subTitle: 'Hypoglasemia', rightSubTitle: 'June 12', circleColor: "#FFD25B",),
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