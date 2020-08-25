import 'package:flutter/material.dart';
import '../../reusables/color_converter.dart';

class Document extends StatefulWidget {
  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  @override
  Widget build(BuildContext context) {

    final card_item1 = Container(
                              child: Row(
                                children: <Widget>[
                                    Image.asset("images/document_icon2.png", height: 60,),
                                    SizedBox(width: 5,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                          Text('Cardo Therapy', style: TextStyle(color: hex("#4F4B4B"), fontFamily: "Museo Sans", fontSize: 13.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                                          SizedBox(height: 5.0),
                                          Text('March 8, 2014 1:50 PM', style: TextStyle(color: hex("#000000"), fontFamily: "Museo Sans", fontSize: 11.0, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal),)
                                      ],
                                    ),
                                ],
                              ),
                            );
    
    final card_item2 = Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // Eye View Icons
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.remove_red_eye, color: hex("#DADADA"),),
                                      Text("View", style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 6.0, fontWeight: FontWeight.w600 ),)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  // Download Icons
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.cloud_download, color: hex("#DADADA"),),
                                      Text("download", style: TextStyle(color: hex("#4F4B4B").withOpacity(0.5), fontSize: 6.0, fontWeight: FontWeight.w600 ),)
                                    ],
                                  )
                                ],
                              ),
                            );

    final DocumentCard = Container(
                                  height: 100.0,
                                  // 380.0
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  margin: EdgeInsets.only(top: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color: Colors.black)],
                                    border: Border(right: BorderSide(width: 3.0, color: hex("#7EB0EE")))
                                  ),
                                  
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        // First DFocument Title and Cardio Container
                                        card_item1,
                                        card_item2
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
                  appBar: AppBar(
                    title: Text('Document', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    primary: true,
                    elevation: 0,
                    ),
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
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // Document Cards
                                            DocumentCard,
                                            DocumentCard,
                                            DocumentCard,
                                            DocumentCard,
                                            DocumentCard,
                                            DocumentCard,
                                            DocumentCard,
                                            SizedBox(height: 10.0,)
                                          ],
                                        ),
                                      ),
                                      )
                                    ),
                        )
                      )
                    );
  }
}