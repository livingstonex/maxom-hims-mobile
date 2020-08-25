import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hims_mobile/handlers/helpers.dart';
import 'package:hims_mobile/handlers/requests.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/personcard.dart';
import './diagnosis_details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../reusables/shimmers/general_shimmer.dart';

class Diagnoses extends StatefulWidget {
  @override
  _DiagnosesState createState() => _DiagnosesState();
}

class _DiagnosesState extends State<Diagnoses> {

  // Methods Initialization
  _getDiagnosis() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _userId = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // + _userId
    var _url = "api/doctor/diagnosis/" + _userId.toString();
    print(_url);
    HttpService service = HttpService();
    try {
      var res = await service.getRequest(_url, _token);
      List<Data> diagnosisData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['title'], u['icdCode'],  u['diagnosis'], u['onset'], u['remarks'], u['visitType'], u['prima'], u['chronic'], u['provisional'], u['resolved'], u['doctor']);
        diagnosisData.add(singleData);
      }

      print(diagnosisData.length);
      return diagnosisData;
    } catch (e) {
      print(e);
    }
  }
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
                    title: Text('Diagnosis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                                        
                                        SizedBox(height: 30,),
                                        //  List of Diagnosis
                                        // InkWell(
                                        //   child: PersonCard(title: 'Tuberculosis',),
                                        //   onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => DiagnosisDetails() )); },
                                        //   ),
                                        // PersonCard(title: 'HIV',),
                                        // PersonCard(title: 'Cold',),
                                        // SetUp a Future Builder

                                        FutureBuilder(
                                            future: _getDiagnosis(),
                                            builder: (BuildContext context, snapshot){
                                              try {
                                                  if(snapshot.connectionState == ConnectionState.done){
                                                    if(snapshot.data.length != 0) {
                                                        return ListView.builder(
                                                            itemCount: snapshot.data.length,
                                                            scrollDirection: Axis.vertical,
                                                            shrinkWrap: true,
                                                            itemBuilder: (BuildContext context, int index){
                                                              return InkWell(
                                                                      child: PersonCard(title: snapshot.data[index].title,),
                                                                      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => DiagnosisDetails(data: snapshot.data[index],) )); },
                                                                    );
                                                            },
                                                          );
                                                    }else{
                                                      return Center(child:Text('No Diagnosis on record'));
                                                    }
                                                } else {
                                                  return Container(
                                                            height: MediaQuery.of(context).size.height * 0.5,
                                                            child: GeneralShimmer(),
                                                            // SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                            );
                                                }
                                              } catch (e) {
                                                  print(e);
                                                  return Text('Network Error!');
                                              }
                                            } 
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

class Data {
  // var id;
  var title;
  var icdCode;
  var diagnosis;
  var onset;
  var remarks;
  var visitType;
  var prima;
  var chronic;
  var provisional;
  var resolved;
  var doctor;
  

  Data(this.title, this.icdCode, this.diagnosis, this.onset, this.remarks, this.visitType, this.prima, this.chronic, this.provisional, this.resolved, this.doctor);
}