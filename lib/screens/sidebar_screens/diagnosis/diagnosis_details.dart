import 'package:flutter/material.dart';
import '../../../reusables/color_converter.dart';
import '../../../reusables/cards/personcard.dart';
import '../../../reusables/cards/medicinecard.dart';

class DiagnosisDetails extends StatefulWidget {
  var data;
  DiagnosisDetails({Key key, this.data}): super(key: key);

  @override
  _DiagnosisDetailsState createState() => _DiagnosisDetailsState();
}

class _DiagnosisDetailsState extends State<DiagnosisDetails> {
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
                    title: Text('Diagnosis Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))
                            ),
                          child: SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                        // Content

                                         Padding(
                                            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                            child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                                                  style: TextStyle(color: hex('#C4C4C4'), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "Museo Sans", fontStyle: FontStyle.normal)),
                                          ),
                                          SizedBox(height: 35,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              MedicineCard(title: "Prescriptions", imageUrl: "images/drug.png", backgroundColor: "#F6F7FB",),
                                              MedicineCard(title: "Investigations", imageUrl: "images/syringe.png", backgroundColor: "#F6F7FB",)
                                            ],
                                          ),
                                          SizedBox(height: 35,),
                                          PersonCard(imageUrl: "images/booked_appointment_image.png", title: "Dr. Livingstone", subTitle: "June 2",)

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
}
