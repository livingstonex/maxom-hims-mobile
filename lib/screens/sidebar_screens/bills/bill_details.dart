import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hims_mobile/handlers/helpers.dart';
import 'package:hims_mobile/handlers/requests.dart';
import '../../../reusables/color_converter.dart';
import './bill_success.dart';
import 'package:flutter_paystack/flutter_paystack.dart';


class BillDetails extends StatefulWidget {
  var balance;
  var data;
  BillDetails({Key key, this.balance}): super(key: key);

  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  var publicKey = 'pk_test_7b545e0d7a1aaa0e39782e7d5aa7e9595a8082fc';
  var _hmos = ['AXA', 'Mansard'];
  var _selectedItem = 'AXA';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PaystackPlugin.initialize(publicKey: publicKey);
    _getHMOList();
  }

  // Pay specific bill
  _payBill() async{
    _backendVerify();
    // var drBal = widget.balance.ceil();
    // // print(drBal.runtimeType);
    // Charge charge = Charge()
    //        ..amount = 10000
    //        ..reference = '12345678'
    //        ..email = 'patient@email.com';

    // CheckoutResponse response = await PaystackPlugin.checkout(
    //   context, 
    //   charge: charge,
    //   method: CheckoutMethod.card,
    //   );

    //   print(response);
    //   print(response.message);
    //   print(response.message.runtimeType);

    //   if (response.message == 'Success') {
        
    //     // Navigator.push(context, MaterialPageRoute(builder: (context) => BillSuccess())); 
    //   }
  }

  // Backend Verification
  _backendVerify() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _user = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // widget.historyId.toString()
    // _userId.toString()

    // Variable declarations
    var _url = "api/accountant/paybill";
    Map data = {
                "amount": 100,
                "billIds" : [8, 7, 20],
                "patientId": _userId,
                "item": "title",
                "breakdown": {
                  
                }
              }; 
    
    var jsonData = jsonEncode(data);
    print(jsonData);

    // HttpService service = HttpService();
    //   var res = await service.postRequest(_url, _token, jsonData);
    //   print(res);
    //   return res;
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
                  appBar: AppBar(
                    title: Text('Bills', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    primary: true,
                    elevation: 0,
                    ),
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
                                          padding: EdgeInsets.only(left: 5, top: 30, right: 5, bottom: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Text('Laboratory Test', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),),
                                                  Text('June 12', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),),
                                                ],
                                              ),
                                              SizedBox(height: 30,),
                                              Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text('Select HMO', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal),),

                                                DropdownButton(
                                                    items: _hmos.map((dropdownItem){
                                                      return DropdownMenuItem<String>(
                                                        value: dropdownItem,
                                                        child: Text(dropdownItem)
                                                      );
                                                    }).toList(),  
                                                    
                                                    onChanged: (String newUserValue){
                                                      _setSelectedHMO(newUserValue);
                                                    },
                                                    value: _selectedItem,
                                                    dropdownColor: Colors.blue[300],
                                                  ),

                                              ],
                                            ),
                                              SizedBox(height: 80,),
                                              Image.asset('images/credit_card.png', ),
                                              SizedBox(height: 40,),
                                              Text('N ${widget.balance}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: hex("#4F4B4B"), fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                              SizedBox(height: 40.0,),

                                              // Pay Button
                                              Padding(
                                                  padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(22.0),
                                                    child: MaterialButton(
                                                      disabledColor: Colors.blue[200],
                                                      onPressed: () { 
                                                          _payBill();
                                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => BillSuccess())); 
                                                        },
                                                      height: 47.0,
                                                      // minWidth: MediaQuery.of(context).size * 0.5,
                                                      color: hex("#236DD0"),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text('Pay Bill',
                                                                      style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                                      ),
                                                          SizedBox(width: 10,),
                                                          // _loading ? SpinKitWave(size: 20.0, color: hex("#2575FC"),) : SizedBox()
                                                        ],
                                                      ),
                                                      ),
                                                  ),
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

  // Function definition
  void _setSelectedHMO(String selectedValue){
    setState(() {
      _selectedItem = selectedValue;
    });
  }

  _getHMOList() async{
    var _token = await getToken();
    var _url = "api/accountant/allhmoaccount";
    HttpService service = HttpService();
    var res = await service.getRequest(_url, _token);
    
    print(res);
    // setState(() {
    //   _hmos = res;
    // });
  }

}