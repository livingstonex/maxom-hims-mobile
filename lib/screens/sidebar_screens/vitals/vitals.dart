import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/chartcard.dart';
import '../../../reusables/cards/personcard.dart';
import '../../../handlers/helpers.dart';
import '../../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
// Vitals Details Page
import './vital_details.dart';
import '../../../reusables/shimmers/appointment_shimmer.dart';

class Vitals extends StatefulWidget {
  @override
  _VitalsState createState() => _VitalsState();
}

class _VitalsState extends State<Vitals> {
  var bpGraphData = [0.0, 1.0, 1.5, 2.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var glGraphData = [0.0, 1.0, -1.5, 2.0, -0.5, 0.0, -1.1];
  var hrGraphData = [0.0, -1.0, 1.5, 2.0, -0.5, -1.2, -0.3, 0.0];
  var chGraphData = [0.0, 1.0, -1.5, 1.6, 1.7, -0.5, -1.0, -0.5,];
  var _vitals;

  @override
  void initState() { 
    super.initState();
    _vitals = _getVitals();
  }

// Data(u['id'], u['temperature'], u['temperatureUnit'], u['respiratory'], u['pulse'], u['bloodPressureUpper'], 
      //                         u['bloodPressureLower'], u['weight'], u['weightUnit'], u['height'], u['heightUnit'], u['others'], 
      //                         u['alert'], u['createdAt'], u['updatedAt']);
  // Methods Initialization
 Future<List<Data>> _getVitals() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _user = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // _userId.toString();
    var _url = "api/doctor/patientallvitals/" + _userId.toString();
    HttpService service = HttpService();
    try {
      var res = await service.getRequest(_url, _token);
      print(res);
      List<Data> medData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['id'], u['temperature'], u['temperatureUnit'], u['respiratory'], u['pulse'], u['bloodPressureUpper'], 
                              u['bloodPressureLower'], u['weight'], u['weightUnit'], u['height'], u['heightUnit'], u['others'], 
                              u['createdAt'], u['updatedAt']);
        medData.add(singleData);
      }

      print(medData.length);
      return medData;
    } catch (e) {
      print(e);
    }
  }

  // Refresh Function
  Future<void> _refresh() {
    setState(() {
      _vitals = _getVitals();
    });
  }

  @override
  Widget build(BuildContext context) {
       return  Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [hex("#1A1CF8"), hex("#2575FC").withOpacity(1.0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                      ),
                    image: DecorationImage(image: AssetImage("images/screenshot.png"), fit: BoxFit.fill)
                  ),
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: Text('Vital Signs', style: TextStyle(color: hex('#FEFEFE'), fontSize: 13, fontFamily: "Museo Sans", fontWeight: FontWeight.w700),),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                    ),
                    body: RefreshIndicator(
                            onRefresh: _refresh,
                            displacement: 100,
                          child: SafeArea(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      // ChartCard(backgroundColor: '#F6F7FB', headerText: "Blood Pressure", headerSubText: "In the Norm", rightHeaderNumber: "128", rightHeaderNumberColor: "#1A1CF8", rightHeaderNumberUnit: "mm/hg",)
                                    // First ChartCard Row - Blood Pressure & Glucose
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                                          child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    // Blood Pressure and Glucose
                                                    ChartCard(backgroundColor: '#F6F7FB', backgroundColorOpacity: "", headerText: "Blood Pressure", headerSubText: "In the Norm", rightHeaderNumber: "120/89", rightHeaderNumberColor: "#1A1CF8", rightHeaderNumberUnit: "mm.kg", graphData: bpGraphData, lineColor: '#1A1CF8',),
                                                    ChartCard(backgroundColor: '#E4EAFF', backgroundColorOpacity: "",  headerText: "Glucose", headerSubText: "In the Norm", rightHeaderNumber: "97", rightHeaderNumberColor: "#EBE723", rightHeaderNumberUnit: "mg/dll", graphData: glGraphData, lineColor: '#EBE723',)
                                                  ],
                                                ),
                                          ),

                                      // Second ChartCard Row - Heart Rate & Cholesterol
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                                          child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    // Heart Rate
                                                    ChartCard(backgroundColor: '#e9f9fa', backgroundColorOpacity: "0.68", headerText: "Heart Rate", headerSubText: "In the Norm", rightHeaderNumber: "184", rightHeaderNumberColor: "#FC1600", rightHeaderNumberUnit: "Per Mins", graphData: hrGraphData, lineColor: '#FC1600'),
                                                    // Cholesterol
                                                    ChartCard(backgroundColor: '#EBEFFF', backgroundColorOpacity: "", headerText: "Cholesterol", headerSubText: "In the Norm", rightHeaderNumber: "89", rightHeaderNumberColor: "#119745", rightHeaderNumberUnit: "mg/dll", graphData: chGraphData, lineColor: '#119745')
                                                  ],
                                                ),
                                          ),
                                      // White Curve Container
                                      Container(
                                              padding: EdgeInsets.only(top: 30, ),
                                              width: MediaQuery.of(context).size.width * 1,
                                              height: MediaQuery.of(context).size.height * 0.5,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                                                ),
                                              child: SingleChildScrollView(
                                                                    child: Center(
                                                                          child: Padding( 
                                                                            padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                                                            child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: <Widget>[ 
                                                                              
                                                                            // Render Vital Cards
                                                                            // SetUp a Future Builder
                                                                              FutureBuilder(
                                                                                    future: _vitals,
                                                                                    builder: (BuildContext context, snapshot){
                                                                                      try {
                                                                                          if(snapshot.connectionState == ConnectionState.done){
                                                                                            if(snapshot.data.length != 0) {
                                                                                                return ListView.builder(
                                                                                                    itemCount: snapshot.data.length,
                                                                                                    scrollDirection: Axis.vertical,
                                                                                                    shrinkWrap: true,
                                                                                                    itemBuilder: (BuildContext context, int index){
                                                                                                      // convert string date from api to atetime usable format
                                                                                                      var dt = DateTime.parse(snapshot.data[index].createdAt);
                                                                                                      var newDt = DateFormat.yMMMEd().format(dt);
                                                                                                      return InkWell(
                                                                                                        // rightSubTitle: snapshot.data[index].createdAt != null ? newDt : 'June 2, 2020'
                                                                                                                child: PersonCard(title:'Vitals', imageUrl: "images/booked_appointment_image.png", rightSubTitle: snapshot.data[index].createdAt != null ? snapshot.data[index].createdAt : 'June 2, 2020'),
                                                                                                                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => VitalDetails(title: "Vital Details", data: snapshot.data[index],) )); },
                                                                                                              );
                                                                                                    },
                                                                                                  );
                                                                                            }else{
                                                                                              return Text('No Vitals');
                                                                                            }
                                                                                        } else {
                                                                                          return Container(
                                                                                                    height: MediaQuery.of(context).size.height * 0.4,
                                                                                                    child: AppointmentShimmer(),
                                                                                                    // SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                                                                    );
                                                                                        }
                                                                                      } catch (e) {
                                                                                          print(e);
                                                                                          return Text('Network Error!');
                                                                                      }
                                                                                    } 
                                                                                  ),


                                                                              // InkWell(
                                                                              //   child: PersonCard(imageUrl: "images/booked_appointment_image.png", title: "June 2, 2020", subTitle: "Nurse Titi",),
                                                                              //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => VitalDetails(title: "June 2, 2020",))); },
                                                                              // ),
                                                                              // PersonCard(imageUrl: "images/booked_appointment_image.png", ),
                                                                              // PersonCard(imageUrl: "images/booked_appointment_image.png",  subTitle: "Nurse Titi",),
                                                                              // PersonCard(imageUrl: "images/booked_appointment_image.png",  subTitle: "Nurse Titi",),
                                                                              // PersonCard(imageUrl: "images/booked_appointment_image.png",  subTitle: "Nurse Adewayo",)

                                                                            ],
                                                                            )
                                                                          ),
                                                                    ),
                                                      )
                                              ),
                                    ],
                                  )
                                  ),
                        
                      ),
                    )
                  )
                );
  
  }
}

class Data {
  var id;
  var temperature;
  var temperatureUnit;
  var respiratory;
  var pulse;
  var bloodPressureUpper;
  var bloodPressureLower;
  var weight;
  var weightUnit;
  var height;
  var heightUnit;
  var others;
  // var bool alert;
  String createdAt;
  var updatedAt;

  Data(this.id, this.temperature, this.temperatureUnit, this.respiratory, this.pulse, this.bloodPressureUpper, this.bloodPressureLower,
        this.weight, this.weightUnit, this.height, this.heightUnit, this.others, this.createdAt, this.updatedAt);
}