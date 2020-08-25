import 'package:flutter/material.dart';
import 'package:hims_mobile/reusables/color_converter.dart';
import '../tab_screens/chief_complain.dart';
import '../tab_screens/examination.dart';
import '../tab_screens/diagnosis.dart';
import '../tab_screens/plan.dart';

class MedicalHistoryTabs extends StatelessWidget {
  int historyId;
  MedicalHistoryTabs({this.historyId });
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
                child: DefaultTabController(
                        length: 4, 
                        child: Scaffold(
                          appBar: AppBar(
                            bottom: TabBar(
                              tabs: [
                                      Tab(
                                        // icon: Icon(Icons.linear_scale),
                                        child: Text('Chief Complain', style: TextStyle(color: hex('#FEFEFE'), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),),
                                      Tab(child: Text('Examination', style: TextStyle(color: hex('#FEFEFE'), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),),
                                      Tab(child: Text('Diagnosis', style: TextStyle(color: hex('#FEFEFE'), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),),
                                      Tab(child: Text('Plan', style: TextStyle(color: hex('#FEFEFE'), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),),
                                    ],
                              indicatorColor: hex('#FFFFFF'),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 3.0,
                              ),
                            backgroundColor: Colors.transparent,
                            title: Text('Medical History', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                            centerTitle: true,
                            primary: true,
                            elevation: 0,
                          ),
                          backgroundColor: Colors.transparent,
                          body: TabBarView(
                              children: <Widget>[
                                ChiefComplain(historyId: historyId,),
                                Examination(patientId: historyId,),
                                Diagnosis(),
                                Plan()
                              ],
                            ),
                        )
                        ),
    );
  }
}