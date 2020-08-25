import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../reusables/color_converter.dart';
import '../../../../handlers/helpers.dart';
import 'package:hims_mobile/handlers/requests.dart';

class NOKUpdate extends StatefulWidget {
  int id;
  NOKUpdate({ Key key, this.id }): super(key: key);
  @override
  _NOKUpdateState createState() => _NOKUpdateState();
}

class _NOKUpdateState extends State<NOKUpdate> {
  bool _showForms = false;
  final _formKey = GlobalKey<FormState>();
  Map _data;
  Map _requestedData;
  bool _loading = false;
  String _token;
  int _userId;
  // Field State Data
  String _firstname;
  String _lastname;
  String _email;
  String _telephone;
  String _city;
  String _state;
  String _country;
  String _address;

  // Get User from Shared Preferences
    getUser() async{
      var encodedUser = await getUserData();
      var decodedUser = jsonDecode(encodedUser);
      setState(() {
        _data = decodedUser;
        _userId = decodedUser['id'];
        // _ddata = encodedUser;
      });
    }

  // Get Token Fron Shared Preferences
    getTokenData() async{
      var token = await getToken();
      // print(token);
      setState(() {
        _token = token;
      });
      print(_token);
    }

  // Get profile details and save to shared preferences
    getNOKData() async{
      var url = "api/user/getcontact/" + widget.id.toString();
      print(url);
      HttpService ser = HttpService();
      ser.getRequest(url, _token)
          .then((res){
              print(res);
              // print(res['email']);
              setState((){
                _requestedData = res;
              });
            }, 
            onError: (e){
              print('error: ' + e);
              }
            );
    }

  @override
  void initState() { 
    super.initState();
    getUser();
    getTokenData();
    // getNOKData();
  }

  
  @override
  Widget build(BuildContext context) {
    // Form Fields
    final firstname = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['firstname'] == null ? "" : _requestedData['firstname'],
                                  onSaved: (String val){
                                    setState(() {
                                      _firstname = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Firstname", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                  },
                                )
                          );

    final lastname = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['lastname'] == null ? "" : _requestedData['lastname'],
                                  onSaved: (String val){
                                    setState(() {
                                      _lastname = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Lastname", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    )
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                  },
                                )
                          );

    final emailField = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['email'] == null ? "" : _requestedData['email'],
                                  onSaved: (String val){
                                    setState(() {
                                      _email = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Email", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    )
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                    if( !(value.contains('@')) ){
                                      return "Please enter a valid email";
                                    }
                                  },
                                )
                          );

    final telephone = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['telephone'] == null ? "" : _requestedData['telephone'],
                                  onSaved: (String val){
                                    setState(() {
                                      _telephone = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Telephone", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                  },
                                )
                          );

    final city = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['city'] == null ? "" : _requestedData['city'],
                                  onSaved: (String val){
                                    setState(() {
                                      _city = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "City", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                  },
                                )
                          );

    final state = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['state'] == null ? "" : _requestedData['state'],
                                  onSaved: (String val){
                                    setState(() {
                                      _state = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "State", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                  },
                                )
                          );

    final country = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['country'] == null ? "" : _requestedData['country'],
                                  onSaved: (String val){
                                    setState(() {
                                      _country = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Country", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                  },
                                )
                          );

    final address = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['address'] == null ? "" : _requestedData['address'],
                                  onSaved: (String val){
                                    setState(() {
                                      _address = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Address", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                  },
                                )
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
                    title: Text('Next of Kin Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    primary: true,
                    elevation: 0,
                    ),
                  extendBodyBehindAppBar: true,
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: Builder(
                    builder: (BuildContext innerContext){
                      return SafeArea(
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                        // Content
                                         Padding(
                                           padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Text("FirstName:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['firstname'] == null ? "no firstname entered" : _requestedData['firstname'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("LatName:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['lastname'] == null ? "no lastname entered" : _requestedData['lastname'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("Email:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['email'] == null ? "no email entered" : _requestedData['email'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("Telephone:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['telephone'] == null ? "no telephone entered" : _requestedData['telephone'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("City:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['city'] == null ? "no city entered" : _requestedData['city'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("State:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['state'] == null ? "no state entered" : _requestedData['state'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("Country:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['country'] == null ? "no country entered" : _requestedData['country'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("Address:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['address'] == null ? "no address entered" : _requestedData['address'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 30,),
                                             ],
                                           ),
                                         ),

                                        //  Forms
                                        _showForms ? Center(
                                                      child:Form(
                                                        key: _formKey,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            firstname,
                                                            SizedBox(height: 10,),
                                                            lastname,
                                                            SizedBox(height: 10,),
                                                            emailField,
                                                            SizedBox(height: 10,),
                                                            telephone,
                                                            SizedBox(height: 10,),
                                                            city,
                                                            SizedBox(height: 10,),
                                                            state,
                                                            SizedBox(height: 10,),
                                                            country,
                                                            SizedBox(height: 10,),
                                                            address,
                                                            SizedBox(height: 30,),

                                                            // Update Button
                                                            
                                                            Container(
                                                              width: 350, height: 50,
                                                              child: RaisedButton(
                                                                color: hex("#FF99DD"),
                                                                shape: StadiumBorder(),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Text("Update", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                                                    SizedBox(width: 10,),
                                                                    _loading ? Container(height:20, width:20, child:CircularProgressIndicator()) : SizedBox()
                                                                ],
                                                                ),
                                                                onPressed: _loading ? null : () async{
                                                                  _formKey.currentState.validate() ? _formKey.currentState.save() : Scaffold.of(innerContext).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("Please fill in all fields")));
                                                                  if(_formKey.currentState.validate()){
                                                                    Map<String, String> data = {
                                                                                                "firstname": "$_firstname",
                                                                                                "lastname": "$_lastname",
                                                                                                "email": "$_email",
                                                                                                "telephone": "$_telephone",
                                                                                                "city": "$_city",
                                                                                                "state": "$_state",
                                                                                                "country": "$_country",
                                                                                                "address": "$_address",
                                                                                              };
                                                                    var jsonData = jsonEncode(data);
                                                                    getTokenData();
                                                                    // getProfileData();
                                                                    try {
                                                                      setState((){_loading = true;});
                                                                      var url = 'api/user/savenextofkin';
                                                                      // print(url);
                                                                      HttpService serve = HttpService();
                                                                      serve.postRequest(url, jsonData, _token).then((res) {
                                                                        print(res);
                                                                        print(res['message']);
                                                                        getNOKData();
                                                                        setState((){
                                                                          _loading = false; 
                                                                          _showForms = false;
                                                                        });
                                                                        Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.blueAccent));
                                                                      }).catchError((e){
                                                                              print('error: ' + e);
                                                                              setState((){_loading = false;});
                                                                      });
                                                                    } catch (e) {
                                                                      setState((){_loading = false;});
                                                                       print('error in catch: ');
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),

                                                            SizedBox(height: 20,),
                                                            // Close Button
                                                            Center(
                                                                    child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center, 
                                                                    children: <Widget>[
                                                                        Container(width: 350, height: 50,
                                                                          child: RaisedButton(
                                                                            color: hex("#1A1CF8"),
                                                                            shape: StadiumBorder(),
                                                                            child: Text("Back", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                                                            onPressed: _requestedData == null ? null :() {
                                                                              setState(() {
                                                                                _showForms = false;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  )
                                                              
                                                          ],
                                                          )
                                                        ) )
                                                  :
                                                    //  Update Next of Kin Button
                                                    Center(
                                                      child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center, 
                                                      children: <Widget>[
                                                          Container(width: 350, height: 50,
                                                            child: RaisedButton(
                                                              color: hex("#1A1CF8"),
                                                              shape: StadiumBorder(),
                                                              child: Text("Update Profile", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                                              onPressed: _requestedData == null ? null :  () {
                                                                setState(() {
                                                                  _showForms = true;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    )
                                        
                                        ],
                            ),
                                    ),
                                  ),
                         ),
                    ),
                  );
                    },
                  )
                  
                )
              );
  }
}