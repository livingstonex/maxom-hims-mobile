import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../reusables/color_converter.dart';
import '../../../../reusables/cards/examinationcard.dart';
import '../../../../handlers/helpers.dart';
import '../../../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Examination extends StatefulWidget {
  int patientId;
  Examination({Key key, this.patientId}): super(key: key);
  
  @override
  _ExaminationState createState() => _ExaminationState();
}

class _ExaminationState extends State<Examination> {
  // Method definition
  // _getClinicalExams() async{
  //   var _token = await getToken();
  //   // var _userId = jsonDecode(await getUserData())['id'];
  //   // + widget.patientId.toString()
  //   var _url = 'api/doctor/patientclinicalexam/105';

  //   HttpService service = new HttpService();
  //   try {
  //     var res = await service.getRequest(_url, _token); 
  //     print(res);
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  _getClinicalExams() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _user = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // widget.patientId.toString()
    var _url = 'api/doctor/patientclinicalexam/' + _userId.toString();
    print(_url);
    HttpService service = HttpService();
    try {
      var res = await service.getRequest(_url, _token);
      List<Data> examinationData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['generalAppearance']);
        examinationData.add(singleData);
      }

      print(examinationData.length);
      return examinationData;
    } catch (e) {
      print(e);
    }
    
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
                          padding: EdgeInsets.only(top: 10, ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // Content displayed with Future Builders
                                       FutureBuilder(
                                         future: _getClinicalExams(),
                                         builder: (BuildContext context, snapshot){
                                            try {
                                              if(snapshot.connectionState == ConnectionState.done){
                                                 if(snapshot.data.length != 0) {
                                                      return ListView.builder(
                                                                    itemCount: snapshot.data.length,
                                                                    scrollDirection: Axis.vertical,
                                                                    shrinkWrap: true,
                                                                    itemBuilder: (BuildContext context, int index){
                                                                      return ExaminationCard(title: snapshot.data[index].generalAppearance,);
                                                                    },
                                                                  );
                                                  }else{
                                                    return Padding(
                                                      padding: EdgeInsets.only(top: 40.0,),
                                                      child: Text('No Examinations Yet'));
                                                  }
                                              }else{
                                                return Container(
                                                                height: MediaQuery.of(context).size.height * 0.4,
                                                                child: SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                              );
                                              }
                                            } catch (e) {
                                               print(e);
                                              return Text('Netwotk Error!');
                                            }
                                         }
                                         ),
                                      //  ExaminationCard(title: 'Endocrine System',),
                                      //  ExaminationCard(title: 'Endocrine System',),
                                      //  ExaminationCard(title: 'Endocrine System',),
                                      //  ExaminationCard(title: 'Endocrine System',),
                                      //  ExaminationCard(title: 'Endocrine System',),
                                      //  ExaminationCard(title: 'Endocrine System',),
                                      //  ExaminationCard(title: 'Endocrine System',),
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

class Data {
  final String generalAppearance;

  Data(this.generalAppearance);
}