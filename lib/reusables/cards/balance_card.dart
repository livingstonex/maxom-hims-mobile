import 'package:flutter/material.dart';
import '../color_converter.dart';

class BalanceCard extends StatefulWidget {
  String balance;

  BalanceCard ({ Key key, this.balance }): super(key: key);
  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
                child: Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width *   0.6,
                        margin: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [BoxShadow(color: Colors.black)],
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient( 
                            colors: [hex('#236DD0'), hex('#1D40CE').withOpacity(1.0)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight
                          )
                        ),
                        
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                Text('Balance', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue[50], fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                                SizedBox(height: 10.0,),
                                widget.balance != null ? Text(widget.balance, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),) : Text('N0.000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white, fontStyle: FontStyle.normal, fontFamily: "Museo Sans"),),
                            ],
                          ),
                          ),
                      )
                    );
  }
}