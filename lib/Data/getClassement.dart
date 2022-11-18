// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings

import 'package:projet1/Data/Connection.dart';
import 'package:projet1/Model/Standings.dart';
import 'package:http/http.dart' as http;

Future<Standings> getClassment() async {
  Standings std = Standings();
  try {
    if (Connection.token.isNotEmpty) {
      String url = "http://api.cup2022.ir/api/v1/standings";
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${Connection.token}",
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        std = standingsFromJson(response.body);

      } else {
      }
    }
  } catch (e) {
    print(e);
  }

  return std;
}
