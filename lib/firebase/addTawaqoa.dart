// ignore_for_file: prefer_interpolation_to_compose_strings, file_names, avoid_print, empty_catches, unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';

Future<void> addPere(List<int> pre, int id) async {
  try {
    if (accepteAdd(pre)) {
      String? email = FirebaseAuth.instance.currentUser!.email;
      CollectionReference users = FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .collection("Tawaqo3");
      users.doc(id.toString()).set({
        "id": id,
        "homeEx": pre[0],
        "awayEx": pre[1],
        "maxBut": pre[2],
        "minBut": pre[3],
        "Qagne": pre[4],
        "pts": 0
      });
    }
  } catch (e) {
    print(e);
  }
}

Future<void> UpdateTaw(int? id, int pt, String email) async {
  try {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection("Tawaqo3");
    users.doc(id.toString()).update({"pts": pt});
  } catch (e) {
    print(e);
  }
}

Future<void> UpdatePTS(int pt, String email) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(email).update({"pts": pt});
  } catch (e) {
    print(e);
  }
}

bool accepteAdd(List<int> pre) {
  for (var i = 0; i < pre.length; i++) {
    if (pre[i] != -1) {
      if (i == 0) {
        pre[2] = -1;
        pre[3] = -1;
        pre[4] = -1;
      }
      return true;
    }
  }
  return false;
}
