import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../document/documents.dart';
import '../doctor/doctors_favorite.dart';
import './personal_info/personal_info_home.dart';
import '../../handlers/helpers.dart';
import '../../handlers/requests.dart';
import '../../reusables/color_converter.dart';
import 'package:image_picker/image_picker.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    int _id;
    PickedFile _image;
    ImagePicker picker = ImagePicker();
    String _profileUrl;


  @override
  void initState() {
    // TODO: implement initState
     _profileUrl = getProfileUrl();
    super.initState();
  }

  // ==================== METHODS DECLERATIONS ====================== //
    // Get Image
    void _open_gallery() async {
          var image = await picker.getImage(source: ImageSource.gallery, );
          setState(() {
              _image = image;
            });
          print(_image);
          // var formData = FormData(_image); 
          // Send Image to Server 
          _photoUpdate(_image);
    }

    
    // Get User
    getUser() async{
      // Get generic user data
      var encodedUser = await getUserData();
      var decodedUser = jsonDecode(encodedUser);

      // Get Profile picture url
      var profile = await jsonDecode(getProfileUrl());

      print(profile.runtimeType);
      setState(() {
        _id = decodedUser['id'];
        _profileUrl = profile;
      });
    }

    getProfileUrl() async{
      // Get Profile picture url
      var profile = await jsonDecode(getProfileUrl());
      print(profile.runtimeType);
      return profile;
    }

    // Post Photo
    _photoUpdate(imageFile) async{
      // var _token = await getToken();
      // var _url = 'https://maxomware-hims.herokuapp.com/api/user/uploadphoto';
      // HttpService service = new HttpService();
      // FormData formData = FormData.fromMap({'file': imageFile});
      //   try {
      //     var response = await service.postPhotoRequest(_url, formData, _token);
      //     print(response.body);
      //   } catch (e) {
      //     print(e);
      //   }

      try {
          var _url = 'https://maxomware-hims.herokuapp.com/api/user/uploadphoto';
          var _token = await getToken();
          final dio = Dio();

          dio.options.headers = {
            'Content-Type': 'multipart/form-data',
            'authorization': '${_token}'
          };

          final file = await MultipartFile.fromFile(imageFile.path, filename: 'profile',);

          final formData = FormData.fromMap({'file': file}); // 'file' - this is an api key, can be different

          final response = await dio.post( // or dio.put
            _url,
            data: formData,
          );

          print(response.data['photo']);

          // Save the returned photo string to shared preferences
          setProfileUrl(response.data['photo']);
          setState(() {
            _profileUrl = response.data['photo'];
          });
        } catch (err) {
          print('uploading error: $err');
        }
    }

    Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    print(res);
    return res.reasonPhrase;
  }
    

  @override
  Widget build(BuildContext context) {
    final personal_information = Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color:Colors.grey[500])],
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10, bottom:10),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset("images/user_icon.png"),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text("Personal Information", style: TextStyle(color: hex("#4A4A4A"), fontSize: 14, fontWeight:FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Poppins"),),
                                            )
                                        ],
                                      ),
                                    ),
                                  );

    final payment_information = Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color:Colors.grey[500])],
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10, bottom:10),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset("images/credit_card_icon.png"),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text("Payment Information", style: TextStyle(color: hex("#4A4A4A"), fontSize: 14, fontWeight:FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Poppins"),),
                                          )
                                      ],
                                    ),
                                  ),
                                );

    final favorite_doctor = Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color:Colors.grey[500])],
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10, bottom:10),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset("images/favorite_star_icon.png"),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text("Favorite Doctors", style: TextStyle(color: hex("#4A4A4A"), fontSize: 14, fontWeight:FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Poppins"),),
                                          )
                                      ],
                                    ),
                                  ),
                                );

    final medical_history = Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color:Colors.grey[500])],
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10, bottom:10),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset("images/clinic_history_icon.png"),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text("Medical History", style: TextStyle(color: hex("#4A4A4A"), fontSize: 14, fontWeight:FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Poppins"),),
                                          )
                                      ],
                                    ),
                                  ),
                                );

    final documents = Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color:Colors.grey[500])],
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10, bottom:10),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset("images/documents_icon.png"),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text("Documents", style: TextStyle(color: hex("#4A4A4A"), fontSize: 14, fontWeight:FontWeight.normal, fontStyle: FontStyle.normal, fontFamily: "Poppins"),),
                                          )
                                      ],
                                    ),
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
                        body: SafeArea(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      // Profile Image Container
                                         Container(
                                            height: 210,
                                            width: 210,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: hex("#BAC4C9").withOpacity(0.2),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: hex("#BAC4C9").withOpacity(0.3),
                                                    ),
                                                child: Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(100),
                                                                color: hex("#BAC4C9").withOpacity(0.4),
                                                                ),
                                                            child: Padding(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(100),
                                                                            color: hex("#BAC4C9").withOpacity(0.5),
                                                                            ),
                                                                        child: CircleAvatar(
                                                                                  radius: 18.0,
                                                                                  // _image == null ? Image.asset("images/mayowa_pix.png") : Image.file(_image)
                                                                                   child: ClipRRect(borderRadius: BorderRadius.circular(100),
                                                                                     child: _profileUrl == null ? Image.asset("images/mayowa_pix.png") : Image.network(_profileUrl),
                                                                                   ),
                                                                                   backgroundColor: Colors.transparent,
                                                                                  ),
                                                                      ),
                                                                    ),
                                                            ),
                                                      ),
                                              ),
                                            ),
                                          ),

                                          
                                          // Plus Button
                                          Positioned(
                                            bottom: 15,
                                            right: 10,
                                            child: FloatingActionButton(
                                              onPressed: _open_gallery,
                                              // () async {
                                              //   var _urll = 'https://maxomware-hims.herokuapp.com/api/user/uploadphoto';
                                              //   ImagePicker picker = ImagePicker();
                                              //   var file = await picker.getImage(source: ImageSource.gallery);
                                              //   var res = await uploadImage(file.path, _urll);
                                              //   print(res);
                                              // },
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.add, color: hex("#1A1CF8"), size: 35,),
                                              ),
                                          ),
                                          
                                    ],
                                  ),
                                 
                                  SizedBox(height: 17,),
                                  Text("Adegunwa Mayowa", style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "Museo Sans", fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
                                  SizedBox(height: 20,),
                                  // White Curve Container
                                  Container(
                                          padding: EdgeInsets.only(top: 30, ),
                                          width: MediaQuery.of(context).size.width * 1,
                                          height: MediaQuery.of(context).size.height * 0.45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                                            ),
                                          child: SingleChildScrollView(
                                                                child: Center(
                                                                      child: Padding( 
                                                                        padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                                                        child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          InkWell(
                                                                            onTap: (){
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoHome(id: _id,) ));
                                                                            },
                                                                            child: personal_information,),
                                                                          SizedBox(height: 10,),
                                                                          payment_information,
                                                                          SizedBox(height: 10,),
                                                                          InkWell(
                                                                            onTap: (){
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteDoctor()));
                                                                            },
                                                                            child: favorite_doctor,),
                                                                          // favorite_doctor,
                                                                          SizedBox(height: 10,),
                                                                          medical_history,
                                                                          SizedBox(height: 10,),
                                                                          InkWell(
                                                                            onTap: (){
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Document()));
                                                                            },
                                                                            child: documents,)
                                                                          // documents
                                                                        ],
                                                                       )
                                                                      ),
                                                                ),
                                                  )
                                          ),
                                ],
                              )
                              ),
                          
                        )
                      )
                    );
  }
}