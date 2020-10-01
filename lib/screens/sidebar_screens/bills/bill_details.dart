import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hims_mobile/handlers/helpers.dart';
import 'package:hims_mobile/handlers/requests.dart';
import 'package:hims_mobile/screens/sidebar_screens/bills/tab_screens/outstanding_bills.dart';
import 'package:hims_mobile/screens/sidebar_screens/bills/top_tab_bar/bills_tabs.dart';
import '../../../reusables/color_converter.dart';
import './bill_success.dart';
import 'package:flutter_paystack/flutter_paystack.dart';


class BillDetails extends StatefulWidget {
  var balance;
  var data;
  BillDetails({Key key, this.balance, this.data}): super(key: key);

  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  var publicKey = 'pk_test_7b545e0d7a1aaa0e39782e7d5aa7e9595a8082fc';
  List _hmos = [];
  var _selectedItem;
  var _policy;
  var _singleHMO;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PaystackPlugin.initialize(publicKey: publicKey);
    _getHMOList();
    // print(widget.data['refNo']);
  }
    

  // Pay specific bill
  _payBill() async{
    // print(_singleHMO['referenceNo']);
    var bal = widget.balance.toDouble(); 
    // var bal = 1000.0;
    // _backendVerify(1000, 'kbhk', false);
    bool hmo = false;

    // Calculate this discount based on if HMO is selected
      // First check that _policy is not null
      if(_policy != null){
        print('Policy discount is not null');
        var discountAmount = (_policy['discount'] / 100) * bal;
        bal = bal - discountAmount;
        hmo = true;
        print(bal);
      }
      // print(bal);

    // Get User Email
    var _userEmail = jsonDecode(await getUserData())['email'];
    // print(_userEmail);

    // If bal is less than N100, you are still going to pay N100
    if((bal.ceil()) < 100){
       bal = 100;
    }

    // Create a Charge Object
    Charge charge = Charge()
           ..amount = bal.ceil() * 100
          //  Replace reference with widget.data['refNo']
           ..reference = '123456788888888866665544reerrd'
           ..email = _userEmail;
    
    print(charge.amount);
     
   
    // Create the CheckoutResponse (i.e actual payment)
    CheckoutResponse response = await PaystackPlugin.checkout(
      context, 
      charge: charge,
      method: CheckoutMethod.card,
    );

    print(response);
    print(response.message);

    // Check response message and take action based on that
    if (response.message == 'Success') {
        print('payment successful');
        if((_policy != null) && (_singleHMO != null)){
          _backendVerify(bal, response.reference, hmo, policyId: _policy['id'], hmoReferenceNo: _singleHMO['referenceNo']);
          return;
        }

        _backendVerify(bal, response.reference, hmo);
      }
  }

  // Backend Verification
  _backendVerify(double amount, String reference, bool hmo, {int policyId, String hmoReferenceNo}) async{
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
                "amount": "$amount",
                "billIds" : [widget.data['id']],
                "patientId": "$_userId",
                "item": widget.data['item'],
                "breakdown": {
                  "card": true,
                  "cardAmount": "$amount",
                  "cardBankId": 0,
                  "cardRef": "$reference",
                  "hmo":  hmo,
                  "hmoPolicyId": (hmo && (policyId != null)) ? policyId : 0,
                  "hmoRefNo": (hmo && (hmoReferenceNo != null)) ? "$hmoReferenceNo" : ""
                }
              }; 
    
    var jsonData = jsonEncode(data);
    print(data);

    HttpService service = HttpService();
      var res = await service.postRequest(_url, jsonData, _token);
      print(res);
      // print(res.status);
    
      // If response status is 200 (success), navigate to the bill_success page
      if(res['code'] == 0){
       Navigator.push(context, MaterialPageRoute(builder: (context) => BillSuccess(success: res['message'],))); 
       return;
      }

       // If response status is 400 (error), navigate to the bill_success page
      if(res['code'] == 400){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Verification Failed?'),
                  content: Text('Verification was not successfull, contact admin.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: (){
                        // Navigator.of(context).pop(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BillsTabs() )); 
                        // return;
                      },
                    ),
                  ],
                );
              }
            );
      }

      // print("There was an error");
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
                                                  Text(widget.data['createdAt'], style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),),
                                                ],
                                              ),
                                              SizedBox(height: 30,),
                                              Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text('Select HMO', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal),),

                                                DropdownButton(
                                                    items: _hmos.map((dropdownItem){
                                                      // print(_hmos[1]['insurancePolicy']['title']);
                                                      // print(dropdownItem['insurancePolicy']['title']);
                                                      return DropdownMenuItem(
                                                        value: dropdownItem['id'],
                                                        child: Text(dropdownItem['insurancePolicy']['title']),
                                                        onTap: (){
                                                          print(dropdownItem['insurancePolicy']);
                                                          setState(() {
                                                            _policy = dropdownItem['insurancePolicy'];
                                                            _singleHMO = dropdownItem;
                                                          });
                                                        },
                                                        );
                                                    }).toList(),  
                                                    
                                                    /* 
                                                      Remember to put the check for balance < 100, like  this:
                                                      onChanged: (widget.balance < 100) ? null : (value) {
                                                        _setSelectedHMO(value);
                                                      },
                                                     */

                                                    onChanged: (value) {
                                                      _setSelectedHMO(value);
                                                    },

                                                    value: _selectedItem,
                                                    dropdownColor: Colors.blue[300],
                                                    isDense: true,
                                                    hint: Text('Select HMO'),
                                                    disabledHint: Text('Disabled'),
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

  // Function definitions
  void _setSelectedHMO(selectedValue){
    setState(() {
      _selectedItem = selectedValue;
    });

    print(_policy['discount']);
  }

  _getHMOList() async{
    var _token = await getToken();
    var _userID = jsonDecode(await getUserData())['id'];
    var _url = "api/user/coveragebypatient/68";
    HttpService service = HttpService();
    var res = await service.getRequest(_url, _token);

    // print(res);
    setState(() {
      _hmos = res;
    });
    return res;
  }

}

class Data {
  final int id;
  var insurancePolicy;
  // final int discount;
  // final int ceiling; 
  Data(this.id, this.insurancePolicy, 
  // this.discount, this.ceiling
  );
}