import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../reusables/color_converter.dart';
import '../../../../reusables/cards/personcard.dart';
import '../../../../handlers/helpers.dart';
import '../../../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Diagnosis extends StatefulWidget {
  int patientId;
  Diagnosis({Key key, this.patientId}): super(key: key);
  
  @override
  _DiagnosisState createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  var _diagnosis;

  @override
  void initState() { 
    super.initState();
    _diagnosis = _getDiagnosisList();
  }

  // Method Definition
  // _getDiagnosisList() async{
  //   var _token = await getToken();
  //   // var _userId = jsonDecode(await getUserData())['id'];
  //   // + widget.patientId.toString();
  //   var _url = 'api/doctor/patientclinicalexam/' + widget.patientId.toString();

  //   HttpService service = new HttpService();
  //   try {
  //     var res = await service.getRequest(_url, _token); 
  //     print(res);
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

   _getDiagnosisList() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _user = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // widget.patientId.toString()
    var _url = "api/doctor/diagnosis/" + _userId.toString();
    print(_url);
    HttpService service = HttpService();
    try {
      var res = await service.getRequest(_url, _token);
      List<Data> diagnosisData = [];
      for (var u in res) {
        print(u['title'].runtimeType);
        Data singleData = Data(u['title'],);
        diagnosisData.add(singleData);
      }

      print(diagnosisData.length);
      return diagnosisData;
    } catch (e) {
      print(e);
    }
    
  }

  // Refresh Function
  Future<void> _refresh(){
    setState(() {
      _diagnosis = _getDiagnosisList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.only(top:5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [hex("#1A1CF8"), hex("#2575FC").withOpacity(1.0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                    ),
                  image: DecorationImage(image: AssetImage("images/screenshot.png"), fit: BoxFit.fill)
                ),
                child: Scaffold(
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
                                              // Build Content using Future Builders
                                              FutureBuilder(
                                                future: _diagnosis,
                                                builder: (BuildContext context, snapshot){
                                                    try {
                                                      if(snapshot.connectionState == ConnectionState.done){
                                                        // print(snapshot.data);
                                                        if(snapshot.data.length != 0) {
                                                            return ListView.builder(
                                                                    itemCount: snapshot.data.length,
                                                                    scrollDirection: Axis.vertical,
                                                                    shrinkWrap: true,
                                                                    itemBuilder: (BuildContext context, int index){
                                                                      return PersonCard(title: snapshot.data[index].title,);
                                                                    },
                                                                  );
                                                        }else{
                                                          return Text('No Diagnosis Yet');
                                                        }
                                                        
                                                      } else {
                                                        return Container(
                                                                  height: MediaQuery.of(context).size.height * 0.4,
                                                                  child:SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                                  );
                                                      }
                                                    } catch (e) {
                                                      print(e);
                                                      return Text('Netwotk Error!');
                                                    }
                                                  }
                                                ), 
                                              // PersonCard(title: 'Tuberculosis',),
                                              // PersonCard(title: 'HIV',),
                                              // PersonCard(title: 'Cold',)
                                              ],
                                            ),
                                    ),
                                  ),
                                 ),


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
  final String title;

  Data(this.title);
}