import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import './top_tab_bar/medical_history_tabs.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/personcard.dart';
import '../../../handlers/helpers.dart';
import '../../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../reusables/shimmers/general_shimmer.dart';

class MedicalHistoryHome extends StatefulWidget {
  @override
  _MedicalHistoryHomeState createState() => _MedicalHistoryHomeState();
}

class _MedicalHistoryHomeState extends State<MedicalHistoryHome> {
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
  // Methods Initialization
  Future<List<Data>> _getMedicalHistory() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _user = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    var _url = "api/doctor/patienthistory/" + _userId.toString();
    HttpService service = HttpService();
    try {
      var res = await service.getRequest(_url, _token);
      print(res);
      List<Data> medData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['id'], u['doctor'], u['createdAt']);
        medData.add(singleData);
      }

      print(medData.length);
      return medData;
    } catch (e) {
      print(e);
    }
    
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getMedicalHistory();
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
                    title: Text('Medical History', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                                  child: new Center(child: Padding(
                                          padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                            child: Column(mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                // Content
                                                // SizedBox(height: 35,),

                                                // SetUp a Future Builder
                                                FutureBuilder(
                                                  future: _getMedicalHistory(),
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
                                                                              child: PersonCard(title: snapshot.data[index].doctor != null ? snapshot.data[index].doctor : 'No name', imageUrl: "images/booked_appointment_image.png", rightSubTitle: snapshot.data[index].createdAt != null ? snapshot.data[index].createdAt : 'June 2, 2020',),
                                                                              onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalHistoryTabs(historyId: snapshot.data[index].id,) )); },
                                                                            );
                                                                  },
                                                                );
                                                          }else{
                                                            return Text('No Medical History');
                                                          }
                                                      } else {
                                                        return Container(
                                                                  height: MediaQuery.of(context).size.height * 0.6,
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
                                                // snapshot.data[index].doctor
                                                // InkWell(
                                                //   child: PersonCard(title: 'Dr. Livingstone', imageUrl: "images/booked_appointment_image.png", rightSubTitle: 'June 12',),
                                                //   onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalHistoryTabs() )); },
                                                //   ),
                                                // PersonCard(title: 'Dr. Somto', imageUrl: "images/booked_appointment_image.png", rightSubTitle: 'June 12',),
                                                // PersonCard(title: 'Dr. Stanley', imageUrl: "images/booked_appointment_image.png", rightSubTitle: 'June 12',),
                                                // PersonCard(title: 'Dr. Isah', imageUrl: "images/booked_appointment_image.png", rightSubTitle: 'June 12',),
                                                // PersonCard(title: 'Dr. Jules', imageUrl: "images/booked_appointment_image.png", rightSubTitle: 'June 12',),
                                                // PersonCard(title: 'Dr. Jules', imageUrl: "images/booked_appointment_image.png", rightSubTitle: 'June 12',),
                                                // PersonCard(title: 'Dr. Jules', imageUrl: "images/booked_appointment_image.png", rightSubTitle: 'June 12',),
                                              ],
                                              ),
                                          ))
                                ),
                    ),
                  )
                )
              );
  }
}

class Data {
  final int id;
  final String doctor;
  final String createdAt;

  Data(this.id, this.doctor, this.createdAt);
}