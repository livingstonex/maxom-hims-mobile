import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Center(child: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 25.0),),),
          
        )
      )
    );
  }
}