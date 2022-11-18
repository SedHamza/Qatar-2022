// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings, unused_import, avoid_print, file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Connection {
  static String token = "";

  static Future<void> connected() async {
    var msg = jsonEncode({
      "email": "Sedhamza18@gmail.com",
      "password": "0404hamza",
    });
    String url = "http://api.cup2022.ir/api/v1/user/login";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: msg);
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        token = responseJson["data"]["token"].toString();
      } else {
        print("erreur connection " + response.body);
      }
    } catch (erre) {
      token = erre.toString();
      print(erre);
    }
  }
}
