import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hims_mobile/handlers/helpers.dart';
import 'package:hims_mobile/handlers/requests.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/personcard.dart';
import '../../../reusables/cards/medicinecard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './prescription_details.dart';
import '../../../reusables/shimmers/general_shimmer.dart';

class Prescriptions extends StatefulWidget {
  @override
  _PrescriptionsState createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  int medicineCount = 0;
  var _prescription;

  @override
  void initState() { 
    super.initState();
    _prescription = _getPrescription();
  }

  // Methods Initialization
  _getPrescription() async{
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
    try {
      var res = await service.getRequest(_url, _token);
      List<Data> prescriptionData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['medicine'], u['instruction'], u['form'], u['strength'], u['route'], u['dose'], u['frequency'], u['duration'], u['foodRelation'], u['prescribedBy']);
        prescriptionData.add(singleData);
      }

      // Set State for the prescription count
      // setState(() {
      //   medicineCount = prescriptionData.length;
      // });

      print(prescriptionData.length);
      return prescriptionData;
    } catch (e) {
      print(e);
    }
  }


  // Refresh Function
  Future<void> _refresh(){
    setState(() {
      _prescription = _getPrescription();
    });
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
                    title: Text('Prescription', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          // Content
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text('$medicineCount Prescriptions', style: TextStyle(color: hex('#1A1CF8'), fontFamily: "Museo Sans", fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                                                MedicineCard(title: "Prescriptions", imageUrl: "images/medicine_bottle.png", backgroundColor: "#F6F7FB",)
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 35,),
                                          // PersonCard(subTitle: "Fansidar",),
                                          // PersonCard(subTitle: "Fansidar",),
                                          // PersonCard(subTitle: "Fansidar",),

                                          // SetUp a Future Builder
                                                FutureBuilder(
                                                    future: _prescription,
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
                                                                                  child: PersonCard(subTitle: "${snapshot.data[index].medicine}",),
                                                                                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionDetails(data: snapshot.data[index],) )); },
                                                                                  );
                                                                              },
                                                                            );
                                                            }else{
                                                              return Text('No Complaint History');
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


                         // Refresh Button
                           Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: ClipRRect(
                                          borderRadius: BorderRadius.circular(22.0),
                                          child: MaterialButton(
                                            disabledColor: Colors.blue[200],
                                            onPressed: (){
                                              _refresh();
                                            },
                                            height: 47.0,
                                            minWidth: MediaQuery.of(context).size.width * 0.9,
                                            color: hex("#236DD0"),
                                            child: Text('Refresh', 
                                                            style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                          ),                                                   
                                            ),
                                        ),
                                ),
                            ],
                          )
                    ),
                  )
                )
              );
  }
}

class Data {
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
  
  Data(this.medicine, this.instruction, this.form, this.strength, this.route, this.dose, this.frequency, this.duration, this.foodRelation, this.prescribedBy);
}