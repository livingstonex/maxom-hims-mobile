import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


setToken(data) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', data);
}
getToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

// Specific functions
setUserData(data) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user', data);
}

setProfileUrl(url) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('url', url);
}

getUserData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user');
}

getProfileUrl() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('url');
}

// Generic Functions
setData(String key, data) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, data);
}

getData(String key) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}


// Logout Function
logOut() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

// Format Date correctly and return it with the precise time
getDateTime (String date){
  var dt = DateTime.parse(date);
  var newDt = DateFormat.Hm().format(dt);
  var newT = DateFormat.yMMMEd().format(dt);
  return newT + " by " + newDt;
}

// Format date, get only time
getTime (String date){
  var dt = DateTime.parse(date);
  var specificTime = DateFormat.Hm().format(dt);
  return specificTime;
}
