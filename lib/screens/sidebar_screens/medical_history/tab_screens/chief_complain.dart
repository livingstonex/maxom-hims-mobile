import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../../reusables/color_converter.dart';
import '../../../../reusables/cards/personcard.dart';
import '../../../../handlers/helpers.dart';
import '../../../../handlers/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../reusables/cards/complaint_card.dart';


class ChiefComplain extends StatefulWidget {
  int historyId;
  ChiefComplain({Key key, this.historyId}): super(key: key);

  @override
  _ChiefComplainState createState() => _ChiefComplainState();
}

class _ChiefComplainState extends State<ChiefComplain> {
  var _complaints;

  @override
  void initState() { 
    super.initState();
    _complaints = _getCheifComplaint();
  }


  // Methods Initialization
  _getCheifComplaint() async{
    var _token = await getToken();
    var _encodedUser = await getUserData();
    var _decodedUser = jsonDecode(_encodedUser);
    var _userId = _decodedUser['id'];
    // var _user = jsonDecode(await getUserData())['id'];
    
    // Define remote url
    // widget.historyId.toString()
    var _url = "api/doctor/patientcomplaint/" + _userId.toString();
    print(_url);
    HttpService service = HttpService();
    try {
      var res = await service.getRequest(_url, _token);
      List<Data> complaintData = [];
      for (var u in res) {
        print(u['id'].runtimeType);
        Data singleData = Data(u['id'], u['details'],  u['doctor'], u['createdAt'],);
        complaintData.add(singleData);
      }

      print(complaintData.length);
      return complaintData;
    } catch (e) {
      print(e);
    }
  }


  Future<void> _refresh(){
    setState(() {
      _complaints = _getCheifComplaint();
    });
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
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
                                          child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SingleChildScrollView(
                                            child: Center(
                                              child: Padding(
                                                    padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        // ComplaintCard(),
                                                        // ComplaintCard(),
                                                        // ComplaintCard(),
                                                        // ComplaintCard(),
                                                        // ComplaintCard(),
                                                        // ComplaintCard(),
                                                        // ComplaintCard(),
                                                        // ComplaintCard(),
                                                        
                                                         // SetUp a Future Builder
                                                          FutureBuilder(
                                                              future: _complaints,
                                                              builder: (BuildContext context, snapshot){
                                                                try {
                                                                    if(snapshot.connectionState == ConnectionState.done){
                                                                      if(snapshot.data.length != 0) {
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data.length,
                                                                              scrollDirection: Axis.vertical,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (BuildContext context, int index){
                                                                                return ComplaintCard(text: snapshot.data[index].details, createdAt: snapshot.data[index].createdAt, doctor: snapshot.data[index].doctor,);
                                                                              },
                                                                            );
                                                                      }else{
                                                                        return Text('No Complaint History');
                                                                      }
                                                                  } else {
                                                                    return Container(
                                                                              height: MediaQuery.of(context).size.height * 0.6,
                                                                              child:SpinKitWave(size: 30.0, color: hex("#1A1CF8"),)
                                                                              );
                                                                  }
                                                                } catch (e) {
                                                                    print(e);
                                                                    return Text('Network Error!');
                                                                }
                                                              } 
                                                            ),
                                                      ],
                                                    )
                                              ),
                                            ),
                           ),


                                Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: ClipRRect(
                                            borderRadius: BorderRadius.circular(22.0),
                                            child: MaterialButton(
                                              disabledColor: Colors.blue[200],
                                              onPressed: (){
                                                _refresh();
                                              },
                                              height: 47.0,
                                              minWidth: MediaQuery.of(context).size.width * 0.9,
                                              color: hex("#236DD0"),
                                              child: Text('Refresh',
                                                              style: TextStyle(color: hex("#FFFFFF"), fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                                                            ),                                                   
                                              ),
                                          ),
                                        ),
                                  ],
                                ),
                            ),
                            
                      ),
                    )
                  )
                ),
    );
  }
}

class Data {
  final int id;
  final String details;
  final String doctor;
  final String createdAt;
  

  Data(this.id, this.details, this.doctor, this.createdAt);
}