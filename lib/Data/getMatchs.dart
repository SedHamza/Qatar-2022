// ignore_for_file: unused_import, file_names, avoid_print, prefer_interpolation_to_compose_strings

import 'package:projet1/Data/Connection.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/Standings.dart';
import 'package:http/http.dart' as http;

Future<Matchs> getMatchs() async {
  Matchs std = Matchs("", []);
  try {
    if (Connection.token.isNotEmpty) {
      String url = "http://api.cup2022.ir/api/v1/match";
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${Connection.token}",
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        std = matchsFromJson(response.body);
      } else {
      }
    } else {
      print("No connection");
    }
  } catch (e) {    print(e);
}

  return std;
}
