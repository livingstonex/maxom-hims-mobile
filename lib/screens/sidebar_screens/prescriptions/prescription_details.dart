import 'package:flutter/material.dart';
import '../../../reusables/color_converter.dart';
import 'package:slimy_card/slimy_card.dart';


class PrescriptionDetails extends StatefulWidget {
  var data;
  PrescriptionDetails({Key key, this.data}): super(key: key);

  @override
  _PrescriptionDetailsState createState() => _PrescriptionDetailsState();
}

class _PrescriptionDetailsState extends State<PrescriptionDetails> {

  @override
  Widget build(BuildContext context) {
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
                    title: Text('Prescription Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                          padding: EdgeInsets.only(top: 50, ),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                            ),
                          child: SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          // Content
                                          // Padding(
                                          //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //     children: <Widget>[
                                          //       // Text('$medicineCount PrescriptionDetails', style: TextStyle(color: hex('#1A1CF8'), fontFamily: "Museo Sans", fontSize: 13, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                                          //       // MedicineCard(title: "PrescriptionDetails", imageUrl: "images/medicine_bottle.png", backgroundColor: "#F6F7FB",)
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(height: 35,),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            height: MediaQuery.of(context).size.height * 1,
                                            child: ListView(
                                                  children: <Widget>[
                                                    SlimyCard(
                                                      color: Colors.deepPurple[600],
                                                      width: 400,
                                                      topCardHeight: 250,
                                                      bottomCardHeight: 200,
                                                      borderRadius: 15,
                                                      topCardWidget: topCardWidget("images/mayowa_pix.png"),
                                                      bottomCardWidget: bottomCardWidget(),
                                                      slimeEnabled: true,
                                                    ),
                                                  ],
                                                ),
                                          ),

                                          // PersonCard(subTitle: "Fansidar",),
                                          // PersonCard(subTitle: "Fansidar",),
                                          // PersonCard(subTitle: "Fansidar",),


                                        ],
                            ),
                                    ),
                                  ),
                         ),
                    ),
                  )
                )
              );
  }


  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          '${widget.data.medicine}',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 15),
        Text('${widget.data.instruction}',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
      ],
    );
  }



  Widget bottomCardWidget() {
    return Text(
      'It doesn\'t matter \nwhat your name is.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
