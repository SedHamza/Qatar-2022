// ignore_for_file: unrelated_type_equality_checks, file_names, empty_catches, avoid_print, prefer_interpolation_to_compose_strings

import 'package:projet1/Data/Connection.dart';
import 'package:http/http.dart' as http;
import 'package:projet1/Model/Team.dart';

Future<List<Teams>> getTeams() async {
  List<Teams> lst = [];

  try {
    if (Connection.token.isNotEmpty) {
      String url = "http://api.cup2022.ir/api/v1/team";
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${Connection.token}",
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        lst = TeamsRQFromJson(response.body).data;
      } else {
      }
    }
  } catch (e) {
    print(e);
  }
  return lst;
}
