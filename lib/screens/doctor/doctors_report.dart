import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import '../../reusables/color_converter.dart';
import '../../reusables/cards/chartcard.dart';
import '../../handlers/helpers.dart';
import '../../handlers/requests.dart';


class DoctorsReport extends StatefulWidget {
  @override
  _DoctorsReportState createState() => _DoctorsReportState();
}

class _DoctorsReportState extends State<DoctorsReport> {
  // var temperature;
  // Graph Data
  // var bpGraphData = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var bpUpperGraphData;
  var bpLowerGraphData;
  var tempGraphData;
  var pulseGraphData;
  var respGraphData;


  @override
  void initState() { 
    super.initState();
    _getGraphData();
  }

  _getGraphData(){
    return this._memoizer.runOnce(() async{
        var _token = await getToken();
        var _encodedUser = await getUserData();
        var _decodedUser = jsonDecode(_encodedUser);
        var _userId = _decodedUser['id'];
        // var _user = jsonDecode(await getUserData())['id'];
        
        // Define remote url
        // _userId.toString();
        var _url = "api/user/vitalstatistics/105";
        print(_url);
        HttpService service = HttpService();
  
          var res = await service.getRequest(_url, _token);
          // print(res);
          print(res['temperature'].cast<double>());
        
          setState(() {
            bpUpperGraphData = res['bloodPressureUpper'].cast<double>();
            bpLowerGraphData = res['bloodPressureLower'].cast<double>();
            tempGraphData = res['temperature'].cast<double>();
            pulseGraphData = res['pulse'].cast<double>();
            respGraphData = res['respiratory'].cast<double>();
          });
          
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

  Future<void> _refresh() async{
    setState(() {
      _getGraphData();
      print('graph');
    });
  }
      
  @override
  Widget build(BuildContext context) {
    final BloodPressureCard = Container(
                                height: 104.0,
                                // 180.0
                                width: MediaQuery.of(context).size.width * 0.44,
                                decoration: BoxDecoration(
                                  color: hex("#F6F7FB"),
                                  borderRadius: BorderRadius.circular(6.0)
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // Top Text Row for Heart Rate
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Heart Rate Container
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Blood Pressure', style: TextStyle(color: hex("#4F4B4B"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                              Text('In the Norm', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 8.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                            ],
                                          ),
                                        ),

                                        // 184 Per Mins - Container
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text('120/89', style: TextStyle(color: hex("#1A1CF8"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                              SizedBox(width: 5,),
                                              Text('mm.kg', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 6.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    // Graph Here
                                  ],
                                ),
                              );

    final GlocoseCard = Container(
                                height: 104.0,
                                width: MediaQuery.of(context).size.width * 0.44,
                                decoration: BoxDecoration(
                                  color: hex("#E4EAFF"),
                                  borderRadius: BorderRadius.circular(6.0)
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // Top Text Row for Heart Rate
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Heart Rate Container
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Glocose', style: TextStyle(color: hex("#4F4B4B"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                              Text('In the Norm', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 8.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                            ],
                                          ),
                                        ),

                                        // 184 Per Mins - Container
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text('97', style: TextStyle(color: hex("#EBE723"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                              SizedBox(width: 5,),
                                              Text('mg/dll', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 6.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    // Graph Here
                                  ],
                                ),
                              );

    final HeartRateCard = Container(
                                height: 104.0,
                                width: MediaQuery.of(context).size.width * 0.44,
                                decoration: BoxDecoration(
                                  color: hex("#E9F9FA").withOpacity(0.68),
                                  borderRadius: BorderRadius.circular(6.0)
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // Top Text Row for Heart Rate
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Heart Rate Container
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Heart Rate', style: TextStyle(color: hex("#4F4B4B"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                              Text('In the Norm', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 8.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                            ],
                                          ),
                                        ),

                                        // 184 Per Mins - Container
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text('184', style: TextStyle(color: hex("#FC1600"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                              SizedBox(width: 5,),
                                              Text('Per Mins', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 6.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    // Graph Here
                                  ],
                                ),
                              );

    final CholesterolCard = Container(
                                    height: 104.0,
                                    width: MediaQuery.of(context).size.width * 0.44,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(21, 60, 218, 0.04),
                                      borderRadius: BorderRadius.circular(6.0)
                                    ),
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        // Top Text Row for Heart Rate
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Cholesterol Container
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Cholesterol', style: TextStyle(color: hex("#4F4B4B"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                                  Text('In the Norm', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 8.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                                ],
                                              ),
                                            ),

                                            // 89 mg/dll - Container
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('89', style: TextStyle(color: hex("#119745"), fontSize: 10.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                                  SizedBox(width: 5,),
                                                  Text('mg/dll', style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 6.0, fontWeight: FontWeight.normal, fontFamily: "Museo Sans", fontStyle: FontStyle.normal),),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        // Graph Here
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
                    title: Text('Doctors Report', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Syptoms', style: TextStyle(color: hex("#4F4B4B"), fontSize: 14.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w700),),
                                              InkWell(
                                                child: Text('Refresh'),
                                                onTap: (){
                                                  _refresh();
                                                },
                                              )
                                            ],
                                          ),
                                          // Symptoms Text
                                          SizedBox(height: 10,),
                                          Text(
                                            'Asset tracking refers to the method of tracking physical assets, either by scanning barcode labels attached to the assets or by using tags using GPS, BLE or RFID which broadcast their location. These technologies can also be used for indoor tracking of persons wearing a talocation. These technologies can also be used for indoor tracking of persons wearing a tagg.', 
                                            style: TextStyle(color: hex("#4F4B4B"), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w300),
                                            ),
                                          SizedBox(height: 10,),

                                          // Diagnosis Text
                                          Text('Diagnosis', style: TextStyle(color: hex("#4F4B4B"), fontSize: 14.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w700),),
                                          SizedBox(height: 10,),
                                          Text(
                                            'Asset tracking refers to the method of tracking physical assets, either by scanning barcode labels attached to the assets or by using tags using GPS, BLE or RFID which broadcast their location. These technologies can also be used for indoor tracking of persons wearing a talocation. These technologies can also be used for indoor tracking of persons wearing a tagg.', 
                                            style: TextStyle(color: hex("#4F4B4B"), fontSize: 12.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w300),
                                            ),
                                          SizedBox(height: 10,),


                                          // First Row for Chart Cards
                                           Padding(
                                            padding: EdgeInsets.only(bottom: 20),
                                            child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      // Blood Pressure Chart Card
                                                      ChartCard(backgroundColor: '#F6F7FB', backgroundColorOpacity: "", headerText: "Blood Pressure", headerSubText: "In the Norm", rightHeaderNumber: bpUpperGraphData != null ? "${bpUpperGraphData[bpUpperGraphData.length - 1]}/${bpLowerGraphData[bpLowerGraphData.length - 1]}" : "", rightHeaderNumberColor: "#1A1CF8", rightHeaderNumberUnit: "mm.kg", graphData: bpUpperGraphData, bpLowerData: bpLowerGraphData, lineColor: '#1A1CF8',),

                                                      // Glucose Chart Card
                                                      ChartCard(backgroundColor: '#E4EAFF', backgroundColorOpacity: "",  headerText: "Temperature", headerSubText: "In the Norm", rightHeaderNumber: tempGraphData != null ? "${tempGraphData[tempGraphData.length - 1]}" : "", rightHeaderNumberColor: "#EBE723", rightHeaderNumberUnit: "mg/dll", graphData: tempGraphData, lineColor: '#EBE723',)
                                                    ],
                                                  ),
                                            ),

                                          // Second Row for Chart Cards
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                // Heart Rate Chart Card
                                                ChartCard(backgroundColor: '#e9f9fa', backgroundColorOpacity: "0.68", headerText: "Pulse", headerSubText: "In the Norm", rightHeaderNumber: pulseGraphData != null ? "${pulseGraphData[pulseGraphData.length - 1]}" : "", rightHeaderNumberColor: "#FC1600", rightHeaderNumberUnit: "Per Mins", graphData: pulseGraphData, lineColor: '#FC1600'),
                                                // Cholesterol Chart Card
                                                ChartCard(backgroundColor: '#EBEFFF', backgroundColorOpacity: "", headerText: "Respiratory", headerSubText: "In the Norm", rightHeaderNumber: respGraphData != null ? "${respGraphData[respGraphData.length - 1]}" : "", rightHeaderNumberColor: "#119745", rightHeaderNumberUnit: "mg/dll", graphData: respGraphData, lineColor: '#119745')
                                              ],
                                            ),
                                            ),

                                            // Prescriptions and Result
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                // First prescription
                                                Container(
                                                  height: 50,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text("Prescription", style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 16.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Image.asset("images/prescription_thumbnail_icon.png"),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                                Text("Prescription.pdf", style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 12.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                                Text("29 Jan, 2019", style: TextStyle(color: hex("#4F4B4B").withOpacity(0.4), fontFamily: "Museo Sans", fontSize: 8.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),


                                                Container(
                                                  height: 50,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text("Results", style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 16.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Image.asset("images/prescription_thumbnail_icon.png"),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                                Text("blood-tests.pdf", style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 12.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                                Text("29 Jan, 2019", style: TextStyle(color: hex("#4F4B4B").withOpacity(0.4), fontFamily: "Museo Sans", fontSize: 8.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ))
                                    ],
                                  ),
                                      ),
                                )
                                ),
                  )
                )
              );
  }
}

// class Data {
//   final int id;
//   var temperature;
//   var ;
//   final bool confirmed; 

//   Data(this.id, this.dateTime, this.notes, this.confirmed);
// }