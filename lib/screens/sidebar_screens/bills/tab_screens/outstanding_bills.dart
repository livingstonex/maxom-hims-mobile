import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../../reusables/color_converter.dart';
import '../../../../reusables/cards/personcard.dart';
import '../../../../handlers/helpers.dart';
import '../../../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bill_details.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:intl/intl.dart';
import '../pay_all_bills.dart';


class OutstandingBills extends StatefulWidget {
  final int historyId;
  OutstandingBills({Key key, this.historyId}): super(key: key);

  @override
  _OutstandingBillsState createState() => _OutstandingBillsState();
}

class _OutstandingBillsState extends State<OutstandingBills> {
  var publicKey = 'pk_test_7b545e0d7a1aaa0e39782e7d5aa7e9595a8082fc';
  bool allbills = false;

  @override
  void initState() { 
    super.initState();
    PaystackPlugin.initialize(publicKey: publicKey);
  }
  // Methods Initialization
  // _getOutstandingBills() async{
  //   var _token = await getToken();
  //   var _encodedUser = await getUserData();
  //   var _decodedUser = jsonDecode(_encodedUser);
  //   // var _userId = _decodedUser['id'];
  //   // var _user = jsonDecode(await getUserData())['id'];
    
  //   // Define remote url
  //   // _userId
  //   var _url = "api/accountant/billbypatient/105";
  //   print(_url);
  //   HttpService service = HttpService();
  //   try {
  //     var res = await service.getRequest(_url, _token);
  //     List<Data> outstandingData = [];
  //     for (var u in res) {
  //       print(u['id'].runtimeType);
  //       Data singleData = Data(u['id'], u['details'], u['createdAt'], u['updatedAt']);
  //       outstandingData.add(singleData);
  //     }

  //     print(outstandingData.length);
  //     return outstandingData;
  //   } catch (e) {
  //     print(e);
  //   }
  // }


  // Methods Initialization
  _getOutstandingBills() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _userId = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // _userId _userId.toString()
    var _url = "api/accountant/billbypatient/105";
    print(_url);
    HttpService service = HttpService();
    try {
      var res = await service.getRequest(_url, _token);
      List<Data> outstandingData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['id'], u['refNo'],  u['patient'], u['inpatient'], u['patientId'], u['inpatientId'], u['item'], u['type'], u['department'], u['specialization'], u['paymentType'],
                                u['dr'], u['cr'], u['paid'], u['postedBy'], u['createdAt']);

        outstandingData.add(singleData);
      }

      print(outstandingData.length);
      // setState(() {
      //   allbills = true;
      // });
      return outstandingData;
    } catch (e) {
      print(e);
    }
  }

// Pay all bills
  _payAllBills() async{
    Charge charge = Charge()
            ..amount = 10000
            ..reference = '123456789'
            ..email = 'patient@test.com';
    
    CheckoutResponse response = await PaystackPlugin.checkout(
        context, 
        charge: charge,
        method: CheckoutMethod.card,
      );

    print(response);
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
                                              // InkWell(
                                              //   child: PersonCard(title: 'N95, 000', subTitle: 'Labtest Result', rightSubTitle: 'June 12',),
                                              //   onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => BillDetails() )); }
                                              //   ),
                                              // PersonCard(title: 'N95, 000', subTitle: 'Labtest Result', rightSubTitle: 'June 12',),
                                              // PersonCard(title: 'N95, 000', subTitle: 'Labtest Result', rightSubTitle: 'June 12',),
                                              
                                              // Pay All Bills
                                               Center(
                                                 child: Container(
                                                   width: MediaQuery.of(context).size.width * 0.7,
                                                   child: Padding(
                                                      padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(22.0),
                                                        child: MaterialButton(
                                                          disabledColor: Colors.blue[200],
                                                          onPressed: allbills ? (){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllBills() ));
                                                          } : null,
                                                          height: 47.0,
                                                          // minWidth: MediaQuery.of(context).,
                                                          // minWidth: MediaQuery.of(context).size.width * 0.5,
                                                          color: hex("#236DD0"),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Text('Pay all Bills',
                                                                          style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                                        ),
                                                              SizedBox(width: 10,),
                                                              // _loading ? SpinKitWave(size: 20.0, color: hex("#2575FC"),) : SizedBox()
                                                            ],
                                                          ),
                                                          ),
                                                      ),
                                                      ),
                                                 ),
                                               ),

                                                SizedBox(height: 10,),
                                                // SetUp a Future Builder
                                                FutureBuilder(
                                                  future: _getOutstandingBills(),
                                                  builder: (BuildContext context, snapshot){
                                                    try {
                                                        if(snapshot.connectionState == ConnectionState.done){
                                                          if(snapshot.data.length != 0) {
                                                            setState(() {
                                              //   allbills = true;
                                              // });
                                                              return ListView.builder(
                                                                  itemCount: snapshot.data.length,
                                                                  scrollDirection: Axis.vertical,
                                                                  shrinkWrap: true,
                                                                  itemBuilder: (BuildContext context, int index){
                                                                    return  InkWell(
                                                                                child: PersonCard(title: 'N ${snapshot.data[index].dr}', subTitle: '${snapshot.data[index].item}',  rightSubTitle: '${snapshot.data[index].createdAt}',),
                                                                                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => BillDetails(balance: snapshot.data[index].dr,) )); }
                                                                              );
                                                                  },
                                                                );
                                                          }else{
                                                            return Center(child: Text('No Oustanding bill'));
                                                          }
                                                      } else {
                                                        return Container(
                                                                  height: MediaQuery.of(context).size.height * 0.5,
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