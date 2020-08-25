import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../reusables/color_converter.dart';
import '../../../../handlers/helpers.dart';
import '../../../../handlers/requests.dart';


class ProfileUpdate extends StatefulWidget {
  int id;
  ProfileUpdate ({ Key key, this.id }): super(key: key);
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
    
    Map _data;
    Map _requestedData;
    String _token;
    String _firstname;
    String _lastname;
    String _email;
    String _dob;
    bool _showForms = false;
    final _formKey = GlobalKey<FormState>();
    bool _loading = false;
    // Get User from Shared Preferences
    getUser() async{
      var encodedUser = await getUserData();
      var decodedUser = jsonDecode(encodedUser);
      setState(() {
        _data = decodedUser;
      });
      print(decodedUser);
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
    getProfileData() async{
      var url = "api/user/getuserprofile/" + widget.id.toString();
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
    // TODO: implement initState
    super.initState();
    getUser();
    getTokenData();
    getProfileData();
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
                                  initialValue: _requestedData == null ? "" : _requestedData['lastname'] == null ? "no lastname yet" : _requestedData['lastname'],
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
                                  initialValue: _requestedData == null ? "" : _requestedData['email'] == null ? "no email yet" : _requestedData['email'],
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

  final dob = Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  autofocus: false,
                                  initialValue: _requestedData == null ? "" : _requestedData['dob'] == null ? "no date of birth yet" : _requestedData['dob'],
                                  onSaved: (String val){
                                    setState(() {
                                      _dob = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Date of Birth", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    )
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field!";
                                    }
                                    // if( !(value.contains('@')) ){
                                    //   return "Please enter a valid email";
                                    // }
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
                    title: Text('Profile Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                                               Text(_requestedData == null ? "loading..." : _requestedData['firstname'] == null ? "no firstname yet" : _requestedData['firstname'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("LastName:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['firstname'] == null ? "no lastname yet" : _requestedData['lastname'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("Email:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['email'] == null ? "no email yet" : _requestedData['email'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
                                               SizedBox(height: 10,),
                                               Text("Date of Birth:", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),),
                                               Text(_requestedData == null ? "loading..." : _requestedData['dob'] == null ? "no date of birth yet" : _requestedData['dob'], style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
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
                                                            dob,
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
                                                                  // getProfileData();
                                                                  _formKey.currentState.validate() ? _formKey.currentState.save() : Scaffold.of(innerContext).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("Please fill in all fields")));
                                                                  if(_formKey.currentState.validate()){
                                                                    Map<String, String> data = {
                                                                                                "firstname": "$_firstname",
                                                                                                "lastname": "$_lastname",
                                                                                                "email": "$_email",
                                                                                                "dob": "$_dob"
                                                                                              };
                                                                    var jsonData = jsonEncode(data);
                                                                    try {
                                                                      setState((){_loading = true;});
                                                                      const url = 'api/user/updateprofile';
                                                                      print(url);
                                                                      getTokenData();
                                                                      HttpService serve = HttpService();
                                                                      serve.putRequest(url, jsonData, _token).then((res) {
                                                                        print(res);
                                                                        print(res['message']);
                                                                        getProfileData();
                                                                        setState((){_loading = false; 
                                                                        _showForms = false;
                                                                        });
                                                                        Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.blueAccent));
                                                                      }).catchError((e){
                                                                              // print('error: ' + e);
                                                                              setState((){_loading = false;});
                                                                      });
                                                                    } catch (e) {
                                                                      setState((){_loading = false;});
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
                                                                            color: Colors.green[300],
                                                                            shape: StadiumBorder(),
                                                                            child: Text("Back", style: TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.w600)),
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
                                                    //  Update Profile Button
                                                    Center(
                                                      child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center, 
                                                      children: <Widget>[
                                                          Container(width: 350, height: 50,
                                                            child: RaisedButton(
                                                              color: hex("#1A1CF8"),
                                                              shape: StadiumBorder(),
                                                              child: Text("Update Profile", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                                                              onPressed: _requestedData == null ? null : () {
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
                    }
                    )
                )
              );
  }
}