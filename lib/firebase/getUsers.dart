// ignore_for_file: prefer_interpolation_to_compose_strings, file_names, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet1/Model/tawaqoa.dart';
import 'package:projet1/Model/users.dart';

Future<List<Usr>> GetUsrs() async {
  List<Usr> usrs = [];
  await FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) async {
      Usr usr = Usr(doc["name"], doc["email"], doc["pts"]);

      usrs.add(usr);
    });
  });
  for (var element in usrs) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(element.email)
        .collection("Tawaqo3")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        Tawa9oa tawa9oa = Tawa9oa(doc["id"], doc["homeEx"], doc["awayEx"],
            doc["maxBut"], doc["minBut"], doc["Qagne"], doc["pts"]);
        element.taw.add(tawa9oa);
      });
    });
  }
  return usrs;
}
