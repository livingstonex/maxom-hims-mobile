import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../../reusables/color_converter.dart';
import '../../../../reusables/cards/personcard.dart';
import '../../../../reusables/cards/balance_card.dart';
import '../../../../handlers/helpers.dart';
import '../../../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class AccountHistory extends StatefulWidget {
  final int historyId;
  AccountHistory({Key key, this.historyId}): super(key: key);

  @override
  _AccountHistoryState createState() => _AccountHistoryState();
}

class _AccountHistoryState extends State<AccountHistory> {
  // Methods Initialization
  // _getAccountHistory() async{
  //   var _token = await getToken();
  //   var _encodedUser = await getUserData();
  //   var _decodedUser = jsonDecode(_encodedUser);
  //   // var _userId = _decodedUser['id'];
  //   // var _user = jsonDecode(await getUserData())['id'];
    
  //   // Define remote url
  //   var _url = "api/doctor/patientallvitals/" + widget.historyId.toString();
  //   print(_url);
  //   HttpService service = HttpService();
  //   try {
  //     // var res = await service.getRequest(_url, _token);
  //     // List<Data> complaintData = [];
  //     // for (var u in res) {
  //     //   print(u['id'].runtimeType);
  //     //   Data singleData = Data(u['id'], u['details'], u['createdAt'], u['updatedAt']);
  //     //   complaintData.add(singleData);
  //     // }

  //     // print(complaintData.length);
  //     // return complaintData;
  //   } catch (e) {
  //     print(e);
  //   }
  // }


  // Methods Initialization
  _getAccountHistory() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _userId = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // _userId 
    var _url = "api/accountant/transactionsbypatient/" + _userId.toString();
    print(_url);
    HttpService service = HttpService();
    try {     
      var res = await service.getRequest(_url, _token);
      List<Data> accountHistoryData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['id'], u['refNo'],  u['patient'], u['inpatient'], u['patientId'], u['inpatientId'], u['item'], u['type'], u['department'], u['specialization'], u['paymentType'],
                                u['dr'], u['cr'], u['paid'], u['postedBy'], u['createdAt']);

        accountHistoryData.add(singleData);
      }

      print(accountHistoryData.length);
      return accountHistoryData;
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
                          padding: EdgeInsets.only(top: 30, ),
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              BalanceCard(),
                                              SizedBox(height: 10.0,),
                                              // Container for Filter by date
                                              //  Row of the Forms
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                    //  Filter Result Form
                                                    Text('Filter by Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 0.0),
                                                      child: Container(
                                                        height: 40,
                                                        width: 100,
                                                        child: TextFormField(
                                                            keyboardType: TextInputType.text,
                                                            autofocus: false,
                                                            decoration: InputDecoration(
                                                              hintText: "From", 
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
                                                        height: 40,
                                                        width: 100,
                                                        child: TextFormField(
                                                            keyboardType: TextInputType.text,
                                                            autofocus: false,
                                                            decoration: InputDecoration(
                                                              hintText: "To", 
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

                                              SizedBox(height: 20.0,),
                                              // PersonCard(title: 'N95,000', subTitle: 'Laboratory Test', rightSubTitle: '',),
                                              // PersonCard(title: 'N95,000', subTitle: 'Laboratory Test', rightSubTitle: 'June 12',),
                                              // PersonCard(title: 'N95,000', subTitle: 'Laboratory Test', rightSubTitle: 'June 12',),
                                              
                                               // SetUp a Future Builder
                                                FutureBuilder(
                                                  future: _getAccountHistory(),
                                                  builder: (BuildContext context, snapshot){
                                                    try {
                                                        if(snapshot.connectionState == ConnectionState.done){
                                                          if(snapshot.data.length != 0) {
                                                              return ListView.builder(
                                                                  itemCount: snapshot.data.length,
                                                                  scrollDirection: Axis.vertical,
                                                                  shrinkWrap: true,
                                                                  itemBuilder: (BuildContext context, int index){
                                                                    return PersonCard(title: 'N ${snapshot.data[index].dr}', subTitle: '${snapshot.data[index].item}', rightSubTitle: '${snapshot.data[index].createdAt}',);
                                                                  },
                                                                );
                                                          }else{
                                                            return Center(child: Text('No Account History'));
                                                          }
                                                      } else {
                                                        return Container(
                                                                  height: MediaQuery.of(context).size.height * 0.4,
                                                                  child:SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                                  );
                                                      }
                                                    } catch (e) {
                                                        print(e);
                                                        return Center(child: Text('Network Error!'));
                                                    }
                                                  } 
                                                ),
                                            ],
                                          )
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
  var id;
  var refNo;
  var patient;
  var inpatient;
  var patientId;
  var inpatientId;
  var item;
  var type;
  var department;
  var specialization;
  var paymentType;
  var dr;
  var cr;
  var paid;
  var postedBy;
  var createdAt;

  Data(this.id, this.refNo, this.patient, this.inpatient, this.patientId, this.inpatientId, this.item, this.type, this.department, this.specialization,
        this.paymentType, this.dr, this.cr, this.paid, this.postedBy, this.createdAt);
}