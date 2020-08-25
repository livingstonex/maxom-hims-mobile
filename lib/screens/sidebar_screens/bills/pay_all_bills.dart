import 'package:flutter/material.dart';
import '../../../reusables/color_converter.dart';
import './bill_success.dart';



class AllBills extends StatefulWidget {
  final String total_balance;
  AllBills({Key key, this.total_balance}): super(key: key);

  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<AllBills> {

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
                                              SizedBox(height: 80,),
                                              Image.asset('images/credit_card.png', ),
                                              SizedBox(height: 40,),
                                              Text('N ${widget.total_balance}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: hex("#4F4B4B"), fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                              SizedBox(height: 40.0,),

                                              // Pay Button
                                              Padding(
                                                  padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(22.0),
                                                    child: MaterialButton(
                                                      disabledColor: Colors.blue[200],
                                                      onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => BillSuccess())); },
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
}