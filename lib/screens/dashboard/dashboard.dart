import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import '../../handlers/helpers.dart';
import '../../handlers/requests.dart';
import '../../reusables/color_converter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../appointment/appointment_details.dart';
import '../../reusables/shimmers/dashboard_shimmer.dart';
import '../../reusables/shimmers/drug_list_shimmer.dart';
import '../../reusables/cards/appointment_card.dart';
import '../../reusables/cards/medicinecard.dart';
import '../sidebar_screens/prescriptions/prescription_details.dart';
import '../../reusables/shimmers/network_error.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var firstName;
  var lastName;
  final AsyncMemoizer _memoizer = new AsyncMemoizer();
  final AsyncMemoizer _memoizer_mem = new AsyncMemoizer();
  Future _future;
  var _prescription;
  var _appointments;

  @override
  void initState() { 
    super.initState();
    _getUser();
    _prescription = _getPrescription();
    _appointments = _getAppointments();
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


  _getAppointments(){
    return this._memoizer.runOnce(() async{
        var _token = await getToken();
        var _encodedUser = await getUserData();
        var _decodedUser = jsonDecode(_encodedUser);
        var _userId = _decodedUser['id'];
        // var _user = jsonDecode(await getUserData())['id'];
        
        // Define remote url
        var _url = "api/user/patientappointment/" + _userId.toString();
        print(_url);
        HttpService service = HttpService();
  
          var res = await service.getRequest(_url, _token);
          print(res);
          return res;
          // List<Data> appointmentData = [];
          // for (var u in res) {
          //   Data singleData = Data(u['id'], u['dateTime'],  u['notes'], u['confirmed'],);
          //   appointmentData.add(singleData);
          // }

          // print(appointmentData);
          // return appointmentData;
      });
  }

  // Get prescriptions
    _getPrescription(){
    return this._memoizer_mem.runOnce(() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _user = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // widget.historyId.toString()
    // _userId.toString()
    var _url = "api/doctor/prescriptionbypatient/105";
    print(_url);
    HttpService service = HttpService();
      var res = await service.getRequest(_url, _token);
      print(res);
      return res;

      // List<PrescriptionData> prescriptionData = [];
      // for (var u in res) {
      //   print(u['id'].runtimeType);
      //   PrescriptionData singleData = PrescriptionData(u['medicine'], u['instruction'], u['form'], u['strength'], u['route'], u['dose'], u['frequency'], u['duration'], u['foodRelation'], u['prescribedBy'], u['startDate']);
      //   prescriptionData.add(singleData);
      // }

      // Set State for the prescription count
      // setState(() {
      //   medicineCount = prescriptionData.length;
      // });

      // print(prescriptionData.length);
      // return prescriptionData;
   
  });
  }

  // _onBackPressed function to handle back navigation
  Future<bool> _onBackPressed(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('You are going to exit the application!'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: (){
                Navigator.of(context).pop(false);
              },
            ),

            FlatButton(
              child: Text('Yes'),
              onPressed: (){
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      }
    );
  }

  Future<void> _refresh() async{
    setState(() {
      _prescription = _getPrescription();
      _appointments = _getAppointments();
    });
    print('refresh');
  } 
  @override
  Widget build(BuildContext context) {
    final blood_pressure_card = Container(
                                        height: 80,
                                        width: MediaQuery.of(context).size.width * 0.42,
                                        padding: EdgeInsets.only(left: 10, top: 15, bottom: 8),
                                        decoration: BoxDecoration(
                                          color: hex("#FF4C4D"),
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // Blood Pressure Text Column
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Blood Pressure', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                SizedBox(height: 5,),
                                                Text('130/70', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                SizedBox(height: 10,),
                                                Text('Normal', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                              ],
                                            ),
                                            // Heart Vector Image
                                            Image.asset("images/bloodline_vector.png"),
                                            
                                          ],
                                        ),
                                      );

    final heartbeat_card = Container(
                                    height: 80,
                                    // 185
                                    width: MediaQuery.of(context).size.width * 0.42,
                                    padding: EdgeInsets.only(left: 10, top: 15, bottom: 8),
                                    decoration: BoxDecoration(
                                      color: hex("#5B74D0"),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        // Blood Pressure Text Column
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Heart Beat', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                            SizedBox(height: 5,),
                                            Text('150 CLM', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                            SizedBox(height: 10,),
                                            Text('Normal', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                          ],
                                        ),
                                        // Heart Vector Image
                                        Image.asset("images/heartbeat.png"),
                                        
                                      ],
                                    ),
                                  );

    final water_card = Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width * 0.42,
                              padding: EdgeInsets.only(left: 10, top: 15, bottom: 8),
                              decoration: BoxDecoration(
                                color: hex("#43C7FF"),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // Blood Pressure Text Column
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Water', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                      SizedBox(height: 5,),
                                      Text('10 Glass', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                      SizedBox(height: 5,),
                                      Text('Out of 20', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                    ],
                                  ),
                                  
                                  // Circular Percentage Vector
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 70,
                                        width: 70,
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: hex("#3057F2"),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: hex("#43C7FF"),
                                            shape: BoxShape.circle
                                          ),
                                          child: Center(
                                            child: Text('25%', style: TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w700),),
                                          )
                                        ),
                                      )
                                    ],
                                  )
                                  
                                ],
                              ),
                            );

    final sugar_card = Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width * 0.42,
                              padding: EdgeInsets.only(left: 10, top: 15, bottom: 8),
                              decoration: BoxDecoration(
                                color: hex("#EBA134"),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // Blood Pressure Text Column
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Shuga', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                      SizedBox(height: 5,),
                                      Text('1200', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                      SizedBox(height: 5,),
                                      Text('of 3000', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                    ],
                                  ),
                                  // Heart Vector Image
                                  // Image.asset("images/heartbeat.png"),

                                   // Circular Percentage Vector
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 70,
                                        width: 70,
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: hex("#FFDCB1"),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: hex("#EBA134"),
                                            shape: BoxShape.circle
                                          ),
                                          child: Center(
                                            child: Text('20%', style: TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w700),),
                                          )
                                        ),
                                      )
                                    ],
                                  )
                                  
                                ],
                              ),
                            );

    final three_dots =  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                          ),
                        ),

                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(26, 28, 248, 1),
                            shape: BoxShape.circle
                          ),
                        ),

                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(26, 28, 248, 1),
                            shape: BoxShape.circle
                          ),
                        ),
                      ],
                    );

    final booked_appointment_card =  Center(
                                        child: Container(
                                                height: 100.0,
                                                width: MediaQuery.of(context).size.width * 0.9,
                                                margin: EdgeInsets.only(bottom: 10.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [BoxShadow(color: Colors.black)],
                                                  border: Border(right: BorderSide(width: 3.0, color: hex("#7EB0EE")))
                                                ),
                                                
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        backgroundImage: AssetImage("images/booked_appointment_image.png"),
                                                        radius: 40,
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                            Text('Cardo Therapy', style: TextStyle(color: hex("#1A1CF8"), fontFamily: "Museo Sans", fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                                                            SizedBox(height: 5.0),
                                                            Text('April 5, 2014 7:24 AM', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                                                        ],
                                                      ),
                                                      // Expanded(child: null)
                                                    ],
                                                  ),
                                                  ),
                                              )
                                            );

    final listview_card_drug = Container(
                                      height: 79.0,
                                      width: 117,
                                      margin: EdgeInsets.only(right: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: hex("#F6F7FB")
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.asset("images/drug.png"),
                                          SizedBox(height: 4,),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('Omega 3 - 2 pills', style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 10.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                            ),
                                          SizedBox(height: 3,),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('1:00pm', style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 9.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                                            ),
                                        ],
                                      ),
                                    );

    return WillPopScope(
      onWillPop: _onBackPressed,
          child: RefreshIndicator(
            onRefresh: _refresh,
            backgroundColor: Colors.purple[700],
            color: Colors.white,
            displacement: 100.0,
            child: Container(
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
                            body: Container(
                                  child: SafeArea(
                                  child: Center(
                                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Welcome Text
                                          Padding(
                                            padding: EdgeInsets.only(left: 18),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                    Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),),
                                                    SizedBox(height: 10,),
                                                    Text('${lastName} ${firstName}', style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                    SizedBox(height: 20,),
                                                      ],
                                                    ),
                                            ),
                                        
                                          // White Curve Container
                                          Container(
                                                  padding: EdgeInsets.only(top: 30, ),
                                                  width: MediaQuery.of(context).size.width * 1,
                                                  height: MediaQuery.of(context).size.height * 0.70,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                                                    ),
                                                  child: SingleChildScrollView(
                                                                    child: Padding(
                                                                    padding: EdgeInsets.only(left:10, top:25, right:10, bottom: 30),
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: <Widget>[
                                                                        // Medications Text Header
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                  Text('Medications', style: TextStyle(color:hex("#4A4A4A"), fontFamily: "Museo Sans", fontSize: 16.0, fontWeight: FontWeight.w600 ),),
                                                                                  SizedBox(height: 10,),
                                                                                  Text('Todays dosage and reminder', style: TextStyle(color:hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 10.0, fontWeight: FontWeight.w600 ),)
                                                                              ],
                                                                            ),

                                                                            Text('View all', style: TextStyle(color:hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 10.0, fontWeight: FontWeight.w600 ),)
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 20,),

                                                                        // SetUp a Future Builder for Drug List
                                                                        FutureBuilder(
                                                                            future: _prescription,
                                                                            builder: (BuildContext context, snapshot){
                                                                              try {
                                                                                  if(snapshot.connectionState == ConnectionState.done){
                                                                                    if(snapshot.data.length != 0) {
                                                                                        return Container(
                                                                                                height: 85,
                                                                                                child: ListView.builder(
                                                                                                        itemCount: snapshot.data.length,
                                                                                                        scrollDirection: Axis.horizontal,
                                                                                                        shrinkWrap: true,
                                                                                                        itemBuilder: (BuildContext context, int index){
                                                                                                          // print(snapshot.data[index]['startDate']);
                                                                                                          return InkWell(
                                                                                                            child: MedicineCard(imageUrl: "images/drug.png", title: '${snapshot.data[index]['medicine']}', subTitle: snapshot.data[index]['startDate']),
                                                                                                            // PersonCard(subTitle: "${snapshot.data[index].medicine}",),
                                                                                                            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionDetails(data: snapshot.data[index],) )); },
                                                                                                            );
                                                                                                        },
                                                                                                      ),
                                                                                        );
                                                                                    }else{
                                                                                      return Text('No Complaint History');
                                                                                    }
                                                                                } else {
                                                                                  return  Container(
                                                                                                height: 85,
                                                                                                child: ListView(
                                                                                                  scrollDirection: Axis.horizontal,
                                                                                                  children: <Widget>[
                                                                                                    DrugListhimmer(),
                                                                                                    DrugListhimmer(),
                                                                                                    DrugListhimmer(),
                                                                                                  ],
                                                                                                )
                                                                                              );
                                                                                                              }
                                                                              } catch (e) {
                                                                                  print(e);
                                                                                  return Text('Network Error!');
                                                                              }
                                                                            } 
                                                                          ),
                                                                       
                                                                        SizedBox(height: 20,),
                                                                         // Booked Appointment Text Header
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Text('Booked Appointment', style: TextStyle(color:hex("#4A4A4A"), fontFamily: "Museo Sans", fontSize: 16.0, fontWeight: FontWeight.w600 ),),
                                                                            Text('View all', style: TextStyle(color:hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 10.0, fontWeight: FontWeight.w600 ),)
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 20,),
                                                                        // Booked Appointment Cards
                                                                        // booked_appointment_card,
                                                                        // booked_appointment_card,

                                                                        // SetUp a Future Builder
                                                                        FutureBuilder(
                                                                            // initialData: {},
                                                                            future: _appointments,
                                                                            builder: (BuildContext context, snapshot){
                                                                              // try {
                                                                                if(snapshot.connectionState == ConnectionState.done){
                                                                                  if(snapshot.hasError){
                                                                                    return NetworkErrorShimmer();
                                                                                    // Container( child: Text('Error Loading, Refresh!'), );
                                                                                  } else {
                                                                                      if(snapshot.data != null){
                                                                                              return ListView.builder(
                                                                                                  itemCount: snapshot.data.length,
                                                                                                  scrollDirection: Axis.vertical,
                                                                                                  shrinkWrap: true,
                                                                                                  itemBuilder: (BuildContext context, int index){
                                                                                                    // AppointmentCard(confirmed: snapshot.data[index]['confirmed'], dateTime: snapshot.data[index]['dateTime'],),
                                                                                                    return 
                                                                                                    InkWell(
                                                                                                                child: AppointmentCard(confirmed: snapshot.data[index]['confirmed'], dateTime: snapshot.data[index]['dateTime'],),
                                                                                                                onTap: (){
                                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetails(data: snapshot.data[index],)));
                                                                                                              });
                                                                                                  },
                                                                                                );
                                                                                    }else{ return Text('No appointments'); }
                                                                                    
                                                                                  }
                                                                                } else {
                                                                                  return Container(
                                                                                            height: MediaQuery.of(context).size.height * 0.2,
                                                                                            child: DashboardShimmer(),
                                                                                            // SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                                                            );
                                                                                }
                                                                              // } catch (e) {
                                                                              //     print(e);
                                                                              //     return Text('Network Error!');
                                                                              // }
                                                                            } 
                                                                          ),
                                                                        SizedBox(height: 10,),
                                                                        // Three Blue Dots
                                                                        Center(
                                                                          child: three_dots,
                                                                        ),
                                                                        SizedBox(height: 17,),
                                                                        Divider(color: Color.fromRGBO(176, 190, 197, 0.31),),
                                                                        SizedBox(height: 20,), 
                                                                        // Health Records Header Text Row
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Text('Health Record', style: TextStyle(color:hex("#4A4A4A"), fontFamily: "Museo Sans", fontSize: 16.0, fontWeight: FontWeight.w700 ),),
                                                                            Text('View all', style: TextStyle(color:hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 10.0, fontWeight: FontWeight.w700 ),)
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 20,),
                                                                        // Blood Pressure and HeartBeat Row
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            blood_pressure_card,
                                                                            heartbeat_card,
                                                                          ],
                                                                        ),

                                                                        SizedBox(height: 10,),

                                                                        // Water and Shuga Row
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            water_card,
                                                                            sugar_card,
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                              ),
                                                            
                                                          )
                                                  ),
                                        ],
                                      ),
                                    ),
                              ),
                            )
                          )
                        ),
          ),
    );
  }
}

class Data {
  final int id;
  final String dateTime;
  final String notes;
  final bool confirmed; 

  Data(this.id, this.dateTime, this.notes, this.confirmed);
}

class PrescriptionData {
  var medicine;
  var instruction;
  var form;
  var strength;
  var route;
  var dose;
  var frequency;
  var duration;
  var foodRelation;
  var prescribedBy;
  var startDate;
  
  PrescriptionData(this.medicine, this.instruction, this.form, this.strength, this.route, this.dose, this.frequency, this.duration, this.foodRelation, this.prescribedBy, this.startDate);
}