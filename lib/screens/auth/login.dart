import 'dart:convert';
import '../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import '../../handlers/helpers.dart';
import '../../tab/tab.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  bool _loading = false;


  @override
  Widget build(BuildContext context) {
    final image = Center(
                          child: Image.asset("images/loginimage.png")
                        );
    final gladText = Center(
                          child: Text('Glad to have you back',
                          style: TextStyle(fontSize: 18.0, color:  hex("#4F4B4B"), fontWeight: FontWeight.w300, fontFamily: "Museo Sans"),
                          ));
    final loginText = Padding(
                          padding: EdgeInsets.only(left: 60.0),
                          child: Text('Login', 
                            style: TextStyle(fontSize: 24.0, color: hex("#4A4A4A"), fontWeight: FontWeight.normal, fontFamily: "Museo Sans"),
                          ));

    final emailField = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  enabled: _loading ? false : true,
                                  onSaved: (String val){
                                    setState((){
                                      _username = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "Enter Email", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    )
                                  ),
                                  validator: (value){
                                      if (value.isEmpty){
                                        return "You can't submit an empty email";
                                      }

                                      if (!value.contains('@')){
                                        return "Please use a valid email address";
                                      }
                                  }
                                )
                          );

    final passwordField = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  autofocus: false,
                                  enabled: _loading ? false : true,
                                  onSaved: (String val){
                                    setState(() {
                                      _password = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    hintText: "Enter Password", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    )
                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "You can't submit an empty password";
                                    }

                                    if(value.length < 6){
                                      return "Passwords must be more than 6 characters long";
                                    }


                                  },
                                )
                          );

    final signupText = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: Center(
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                              },
                              child: Text('Dont\'t have an account? Signup',
                              style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600),)
                              ),
                          ),
                          );
    
    final whiteCover = Container(
                          height: MediaQuery.of(context).size.height * 0.90,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(14.0), bottomLeft: Radius.circular(72.0)),
                            color: Colors.white,
                            ),
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (BuildContext innerContext){
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        // Place Custom Widgets Here
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            whiteCover
                          ],
                        ),
                       Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Container(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                    SizedBox(height: 10.0,),
                                    image,
                                    SizedBox(height: 10.0,),
                                    gladText,
                                    SizedBox(height: 20.0,),
                                    loginText,
                                    SizedBox(height: 20.0,),

                                    // Form
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                            emailField,
                                            SizedBox(height: 20.0,),
                                            passwordField,
                                            SizedBox(height: 20.0,),
                                            
                                            // Login Button
                                            Padding(
                                                  padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(22.0),
                                                    child: MaterialButton(
                                                      disabledColor: Colors.blue[200],
                                                      onPressed: _loading ? null : () async{
                                                        // Navigator.push(
                                                        //                 context,
                                                        //                 MaterialPageRoute<void>(
                                                        //                 builder: (BuildContext context) => Loader(),
                                                        //                 fullscreenDialog: true,
                                                        //                 ),
                                                        //                 );
                                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MainTabView()));
                                                          _formKey.currentState.validate() ? _formKey.currentState.save() : print('username: $_username + password: $_password');
                                                        

                                                          // Check if fields are not empty, then compose object and send the request. ====  _email != null && _password != null || _formKey.currentState.validate()
                                                          if(_username.isNotEmpty && _password.isNotEmpty){
                                                            // print("hurrey");
                                                            Map<String, String> data = {
                                                                                          "username": "$_username",
                                                                                          "password" : "$_password"
                                                                                        }; 

                                                            var jsonData = jsonEncode(data);
                                                            print(jsonData);
                                                            try {
                                                              setState(() { _loading = true;});

                                                              const url = "users/login";
                                                              HttpService serv = new HttpService();
                                                              var res = await serv.postRequestNoToken(url, jsonData);
                                                              print(res);
                                                              print(res["message"]);
                                                              if(res['code'] == 0){
                                                                print(jsonData);
                                                                  setState(() {
                                                                    _loading = false;
                                                                    _username = '';
                                                                    _password = '';
                                                                  });
                                                                  // Display success snackbar
                                                                  // print(res);
                                                                  Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.blueAccent,));
                                                                  // // SAVE USER DATA AND TOKEN TO SHARED PREFERENCES
                                                                  // setToken(res['token']);
                                                                  // setUserData(res['user']);

                                                                  // NAVIGATE TO HOME PAGE & SAVE USER DATA AND TOKEN TO SHARED PREFERENCES
                                                                  if(res['user']['roles'][1] == 'PATIENT'){
                                                                    
                                                                    // NAVIGATE TO HOME PAGE
                                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainTabView() ));
                                                                    // SAVE USER DATA AND TOKEN TO SHARED PREFERENCES
                                                                    setToken(res['token']);
                                                                    setUserData(jsonEncode(res['user']));
                                                                    // setProfileUrl(jsonEncode(res['user']['profile']))
                                                                  }else{
                                                                    Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text("You are not a patient!"), backgroundColor: Colors.blueAccent,));
                                                                  }
                                                              }else{
                                                                Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.blueAccent,));
                                                                setState(() {
                                                                    _loading = false;
                                                                    _username = '';
                                                                    _password = '';
                                                                  });
                                                              }

                                                            } catch (e) {
                                                              setState(() {
                                                                _username = '';
                                                                _password = '';
                                                                _loading = false;
                                                              });

                                                            }
                                                          }
                                                      },
                                                      height: 47.0,
                                                      minWidth: 120.0,
                                                      color: hex("#236DD0"),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text('Login',
                                                                      style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                                      ),
                                                          SizedBox(width: 10,),
                                                          _loading ? SpinKitWave(size: 20.0, color: hex("#2575FC"),) : SizedBox()
                                                        ],
                                                      ),
                                                      ),
                                                  ),
                                                  ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 105.0,),
                                 ],
                               ),
                             ),
                             
                            //  signupText,
                           ],
                         ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0, left: 12.0),
                                child: Row(
                                  children: <Widget>[
                                    RotatedBox(
                                    quarterTurns: -1,
                                    child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                    ),
                                    SizedBox(width: 5.0,),
                                    Container(
                                      height: 20.0,
                                      width: 20.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                                  height: 10.0,
                                                  width: 10.0,
                                                  decoration: BoxDecoration(
                                                    color: hex("#FF3623"),
                                                    borderRadius: BorderRadius.all(Radius.circular(32.0))
                                                  ),
                                                ),
                                      ),
                                    )
                                  ],
                                )
                              ),

                               Padding(
                                 padding: const EdgeInsets.only(bottom: 40.0, left: 12.0),
                                 child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Text('SignUp', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                  ),
                               ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0, left: 12.0),
                                child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Text('Forgot Password', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                  ),
                              ),
                           ],
                          ),
                        
                      //  Place the white cover here

                      ],
                    ),

                    signupText,
                  ],
                ),
              ),
            
          );
          },
        )
      )
    );
  }
}