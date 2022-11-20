// ignore_for_file: file_names, camel_case_types, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/firebase/getUsers.dart';

class User_Provider with ChangeNotifier {
  List<Usr> users = [];
  User_Provider() {
    getData();
  }
  getData() async {
    users = await GetUsrs();
    users.sort(
      (b, a) {
        if (a.pts == b.pts) {
          return (-a.taw.length).compareTo((-b.taw.length));
        }
        return a.pts.compareTo(b.pts);
      },
    );
    notifyListeners();
  }
}
