import 'package:flutter/material.dart';
import 'login.dart';
import '../../handlers/requests.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }
  String pass;
  Map<String, String> res;
  // Global Form field
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _firstname;
  String _lastname;
  String _password;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final image = Center(
                          child: Image.asset("images/loginimage.png", height: 150, width: 150,)
                        );
    final gladText = Center(
                          child: Text('Glad to have you back',
                          style: TextStyle(fontSize: 18.0, color:  hex("#4F4B4B"), fontWeight: FontWeight.w300, fontFamily: "Museo Sans"),
                          ));
    final signupText = Padding(
                          padding: EdgeInsets.only(left: 60.0),
                          child: Text('SignUp', 
                            style: TextStyle(fontSize: 24.0, color: hex("#4A4A4A"), fontWeight: FontWeight.normal, fontFamily: "Museo Sans"),
                          ));
    final emailField = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  enabled: loading ? false : true,
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

    final firstname = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  enabled: loading ? false : true,
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
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  enabled: loading ? false : true,
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

    final passwordField = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  autofocus: false,
                                  enabled: loading ? false : true,
                                  onSaved: (String val){
                                    setState(() {
                                      _password = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Password", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    )
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "You can't submit an empty field";
                                    }
                                    
                                    if(value.length < 6) {
                                      return "Passwords must be more than 6 characters long";
                                    }
                                    // if(value.isNotEmpty && value.length > 6){
                                    //   setState(() {
                                    //     pass = value;
                                    //   });
                                    // }
                                  },
                                )
                          );

    final repeatPasswordField = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  autofocus: false,
                                  enabled: loading ? false : true,
                                  decoration: InputDecoration(
                                    labelText: "Repeat Password", 
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0)
                                    )
                                  ),
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "Does not Match Password field";
                                    }

                                    if(value.length < 6){
                                      return "Passwords must be more than 6 characters long";
                                    } 

                                      if( !(value == pass)){
                                        return "Password Fields does not match!";
                                      }
                                  },
                                )
                          );

    final loginText = Padding(
                          padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                          child: Center(
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                              },
                              child: Text('Already have an account? Login',
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
          colors: [Color.fromRGBO(26, 28, 248, 1), Color.fromRGBO(37, 117, 252, 1)],
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.9,
                                      child: SingleChildScrollView(
                                                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                                SizedBox(height: 5.0,),
                                                image,
                                                // SizedBox(height: 5.0,),
                                                gladText,
                                                // SizedBox(height: 5.0,),
                                                signupText,
                                                SizedBox(height: 20.0,), 
                                                // Form
                                                Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      children: <Widget>[
                                                        firstname,
                                                        SizedBox(height: 20.0,),
                                                        lastname,
                                                        SizedBox(height: 20.0,),
                                                        emailField,
                                                        SizedBox(height: 20.0,),
                                                        passwordField,
                                                        SizedBox(height: 20.0,),
                                                        // repeatPasswordField,
                                                        // SizedBox(height: 20.0,),
                                                        // Register Button
                                                        Padding(
                                                            padding: EdgeInsets.only(left: 60.0, right: 20.0,),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(22.0),
                                                              child: MaterialButton(
                                                                disabledColor: Colors.blue[200],
                                                                onPressed: loading ? null : () async{
                                                                  _formKey.currentState.validate() ? _formKey.currentState.save() : 
                                                                  Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text('Form not Valid'), backgroundColor: Colors.blueAccent));
                                                                  
                                                                  // alternatively, you can use: _formKey.currentState.validate()
                                                                  if(_email.isNotEmpty && _password.isNotEmpty && _firstname.isNotEmpty && _lastname.isNotEmpty){
                                                                      Map<String, String> data = {
                                                                        "email": "$_email",
                                                                        "firstname": "$_firstname",
                                                                        "lastname": "$_lastname",
                                                                        "password" : "$_password"
                                                                      };   
                                                                      var dat = jsonEncode(data);
                                                                      // print(dat);    // print(_email.runtimeType);
                                                                      // Make your call here
                                                                      try {
                                                                        setState(() {
                                                                          loading = true;
                                                                        });

                                                                        // Future.delayed(Duration(milliseconds: 5000), (){
                                                                        //       setState(() {
                                                                        //                 loading = false;
                                                                        //               });
                                                                        // });
                                                                       
                                                                        String url = "api/user/signup/patient";
                                                                        HttpService httpServ = new HttpService();
                                                                        var res = await httpServ.postRequestNoToken(url, dat);
                                                                        print(res);
                                                                        print(res['message']);
                                                                        res.isNotEmpty ? setState((){loading = false;}) : "";
                                                                        if(res['code'] == 0){
                                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                                                                        }else{
                                                                          Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.blueAccent,));
                                                                        }
                                                                        

                                                                      } catch (e) {
                                                                        setState(() {
                                                                          loading = false;
                                                                        });
                                                                      }
                                                                      

                                                                      // Response response = await get('https://jsonplaceholder.typicode.com/posts');
                                                                      // String json = response.body;
                                                                      // var obj = jsonDecode(json);
                                                                      // print(obj);

                                                                      // Scaffold.of(innerContext).showSnackBar(SnackBar(content: Text('res.toString()')));
                                                                      // Set the email and password states to empty
                                                                      setState(() {
                                                                        _email = '';
                                                                        _password = '';
                                                                      });
                                                                  }
                                                                  
                                                                },
                                                                height: 47.0,
                                                                minWidth: 120.0,
                                                                color: hex("#236DD0"),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Text('Sign Up',
                                                                          style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                                          ),
                                                                    SizedBox(width: 10,),
                                                                    loading ? SpinKitWave(size: 20.0, color: hex("#2575FC"),) : SizedBox()
                                                                    
                                                                  ],
                                                                )
                                                                ),
                                                            ),
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                // SizedBox(height: 35.0,),
                                                // loginText,
                                          ],
                                        ),
                                      ),
                                    ),

                                    //  Bottom Login Text
                                        // loginText
                                        
                                    
                                  ],
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 40.0, left: 12.0),
                                        child: RotatedBox(
                                                quarterTurns: -1,
                                                child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                                ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 40.0, left: 12.0),
                                        child: Row(
                                          children: <Widget>[
                                            RotatedBox(
                                              quarterTurns: -1,
                                              child: Text('SignUp', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
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
                                          child: Text('Forgot Password', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                          ),
                                      ),
                                  ],
                                  ),
                                
                              //  Place the white cover here

                              ],
                            ),
                            loginText
                          ],
                        ),
                      ),
                    
                  );
          }
          )
      )
    );
  }
}