// import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
// import './helpers.dart';



class HttpService {
  final String baseURL = "https://maxomware-hims.herokuapp.com/";

  // Post Request No Token
  postRequestNoToken(String url, data) async {
    // print(baseURL+url);
    Response res = await post("$baseURL$url", body: data, headers: {'Content-Type' : 'application/json'} );
    return jsonDecode(res.body);  
  }

  // Post Request with Token
  postRequest(String url, data, String token) async {
    Map<String, String> header = {'Content-Type' : 'application/json', 'authorization': '$token' };
    Response res = await http.post("$baseURL$url", body: data, headers: header);
    return jsonDecode(res.body);
    // if(res.body.isNotEmpty){
    //   return jsonDecode(res.body);
    // }
  }

  // Post Photo with Token
  postPhotoRequest(String url, data, String token) async {
    Map<String, String> header = {'Content-Type' : 'multipart/form-data', 'authorization': '$token' };
    Response res = await http.post("$baseURL$url", body: data, headers: header);
    return jsonDecode(res.body);
  }

  // Put Request with Token
  putRequest(String url, data, String token) async {
    Map<String, String> header = {'Content-Type' : 'application/json', 'authorization': '$token' };
    Response res = await http.put("$baseURL$url", body: data, headers: header );

    return jsonDecode(res.body);
  }

  // Get Request No Token
  getRequestNoToken(String url) async {
    Response res = await get("$baseURL$url"); 

    return jsonDecode(res.body);
    // if (res.statusCode == 200){
    //   List<dynamic> body = jsonDecode(res.body);
    //   return body;
    // } else {
      
    //   throw "Can't get Resource";
    // }
  }

  // Get Request with Token
  getRequest(String url, String token) async {
    Map<String, String> header = {'Content-Type' : 'application/json', 'authorization': '$token' };
    Response res = await get("$baseURL$url", headers: header); 

    // if(res.body.isNotEmpty) {
    //     return jsonDecode(res.body);
    // }
    return jsonDecode(res.body);
    
    // if (res.statusCode == 200){
    //   List<dynamic> body = jsonDecode(res.body);
    //   return body;
    // } else {
      
    //   throw "Can't get Resource";
    // }
  }

  // Delete
  deleteRequest(String url) async {
    Response res = await delete("$baseURL$url");
    return res;
  }
}