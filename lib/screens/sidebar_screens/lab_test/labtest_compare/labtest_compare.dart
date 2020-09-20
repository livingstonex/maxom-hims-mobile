import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import '../../../../reusables/color_converter.dart';
import '../../../../reusables/cards/labtestcard.dart';
import '../../../../reusables/circle.dart';
import '../../../../handlers/helpers.dart';
import '../../../../handlers/requests.dart';
import './labtest_compare_details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../reusables/shimmers/general_shimmer.dart';

class LabTestCompare extends StatefulWidget {
  @override
  _LabTestCompareState createState() => _LabTestCompareState();
}

class _LabTestCompareState extends State<LabTestCompare> {
  var dataArray = [];
  var idArray = [];
  var selectedColor = "";
  var i = "";
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() { 
    super.initState();

  }

  // @override
  // void dispose() { 
  //   setState(() {
  //     var dataArray = new List(2);
  //     var idArray = [];
  //     var selectedColor = "";
  //   });
  //   super.dispose();
  // }
  
   _getInvestigations() {
     return this._memoizer.runOnce(() async{
        var _token = await getToken();
        var _encodedUser = await getUserData();
        var _decodedUser = jsonDecode(_encodedUser);
        var _userId = _decodedUser['id'];
        // var _user = jsonDecode(await getUserData())['id'];
        
        // Define remote url
        // _userId.toString()
        var _url = "api/doctor/investigation/singlepatient/68";
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

  _setCompare(obj) {
    if(dataArray.length < 2){
      
      // Cater for Data Array
      if(dataArray.contains(obj) == true){
        // dataArray.add(obj);
        print("item is in dataArray");
        print(dataArray);
        print("case 1");
        return;
      }
      
      if(dataArray.contains(obj) == false){
        dataArray.add(obj);
        print("Item is not inside, it was just added");
        print(dataArray);
        print("case 2");
        return;
      }
      // print(dataArray);

      // Cater for ID Array
      // if(idArray.contains(obj['id']) == true){
      //   // idArray.add(obj['id']);
      //   return;
      // }

      // if(idArray.contains(obj['id']) == false){
      //   idArray.add(obj['id']);
      // }
      // print(idArray);

    }

    // Check if the items in the array are 2 exactly so that you can pop and replace the last item
    if(dataArray.length >= 2){
       if(dataArray.contains(obj) == false){
        // I need a javascript splice equivalent in dart
        dataArray.removeLast();
        dataArray.add(obj);
        print("Item is not inside, the last item was just deleted and this was added");
        print(dataArray);
        print("case 3");
        
        return;
      }

      if(dataArray.contains(obj) == true){
        print("object exists as part of the 2");
        return;
      } 
    }

    print(dataArray);
    print("case 4");
  }

  _checkColor(id){
    if(idArray.contains(id) == true){
      // print(true);
      setState(() {
        selectedColor = "#119745";
      });
    }
    
    if(idArray.contains(id) == false){
      // print(false);
      setState(() {
        selectedColor = "";
      });
     
    }
  }


  _clear(){
    setState(() {
      dataArray = [];
      idArray = [];
      selectedColor = "";
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

                                          // SetUp a Future Builder
                                         FutureBuilder(
                                            // initialData: [],
                                            future: _getInvestigations(),
                                            builder: (BuildContext context, snapshot){
                                              // try {
                                                if(snapshot.connectionState == ConnectionState.done){
                                                  if(snapshot.hasError){
                                                    return Container( child: Text('Error Loading, Refresh!'), );
                                                  } else {
                                                      if(snapshot.data != null){
                                                              return ListView.builder(
                                                                  itemCount: snapshot.data.length,
                                                                  scrollDirection: Axis.vertical,
                                                                  shrinkWrap: true,
                                                                  itemBuilder: (BuildContext context, int index){
                                                                    // AppointmentCard(confirmed: snapshot.data[index]['confirmed'], dateTime: snapshot.data[index]['dateTime'],),
                                                                    // print(snapshot.data[index]['id']);
                                                                    return InkWell(
                                                                                  child: LabTestCard(imageUrl: 'images/syringe2.png', subTitle: 'Full Blood Count', rightSubTitle: 'June 12', circleColor: "#119745", bgColor: selectedColor,),
                                                                                  onTap: (){ 
                                                                                    _setCompare(snapshot.data[index]);
                                                                                    // _checkColor(snapshot.data[index]['id']);
                                                                                    setState(() {
                                                                                      i = "hey";
                                                                                    });
                                                                                    },
                                                                                );
                                                                  },
                                                                );
                                                    }else{ return Text('No Investigations'); }
                                                  }
                                                } else {
                                                  return Container(
                                                            // height: MediaQuery.of(context).size.height * 0.4,
                                                            child: GeneralShimmer(),
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
                                        // Buttons
                                        Center(
                                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center, 
                                          children: <Widget>[
                                            dataArray.length >= 1 ? 
                                              RaisedButton(
                                                onPressed: dataArray.length == 1 ? (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTestCompareDetails(title: 'Full Blood Count', data: dataArray,)));
                                                } : null,
                                                color: hex("#1A1CF8"),
                                                shape: StadiumBorder(),
                                                child: Text("Compare Results", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                              )
                                              : SizedBox() ,
                                              
                                              SizedBox(width: 20,),

                                              dataArray.length >= 1 ? 
                                                RaisedButton(
                                                  onPressed: dataArray.length >= 1 ? (){ _clear(); } : null,
                                                  color: hex("#FFD25B"),
                                                  shape: StadiumBorder(),
                                                  child: Text("Clear", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                                ) 
                                                : SizedBox(),
                                          ],
                                        ),
                                        )
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
  final int id;
  final String diagnosisTitle;
  final String createdAt;

  Data(this.id, this.diagnosisTitle, this.createdAt);
}
