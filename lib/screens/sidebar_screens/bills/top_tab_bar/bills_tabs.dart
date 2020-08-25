import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hims_mobile/reusables/color_converter.dart';
import '../../bills/tab_screens/outstanding_bills.dart';
import '../../bills/tab_screens/account_history.dart';


class BillsTabs extends StatelessWidget {
  // int historyId;
  // BillsTabs({this.historyId });
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
                        length: 2, 
                        child: Scaffold(
                          appBar: AppBar(
                            bottom: TabBar(
                              tabs: [
                                      // Define containers to give width and style to the tabs
                                      Container(
                                        width: 150.0,
                                        child: Tab(
                                          // icon: Icon(Icons.linear_scale),
                                          child: Text('Outstanding Bills', style: TextStyle(color: hex('#FEFEFE'), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),),
                                      ),
                                      Container(
                                        width: 150.0,
                                        child: Tab(child: Text('Account History', style: TextStyle(color: hex('#FEFEFE'), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),)),
                                    ],
                              indicatorColor: hex('#FFFFFF'),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 3.0,
                              ),
                            backgroundColor: Colors.transparent,
                            title: Text('Bills', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                            centerTitle: true,
                            primary: true,
                            elevation: 0,
                          ),
                          backgroundColor: Colors.transparent,
                          body: TabBarView(
                              children: <Widget>[
                                OutstandingBills(),
                                AccountHistory(),
                              ],
                            ),
                        )
                        ),
    );
  }
}