// ignore_for_file: dead_code, avoid_print, unused_local_variable, non_constant_identifier_names, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createAcount(email, password, nom) async {
  String ret = "";
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    ret = credential.user != null ? "Good" : "Erreur";
    AddUser(email, nom);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return "The password provided is too weak.";
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return "Email Invalide";
    print(e);
  }
  return ret;
}

Future<String> login(email, password) async {
  String ret = "";
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return "Good";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'Aucun utilisateur trouvé pour cet e-mail.';
    } else if (e.code == 'wrong-password') {
      return 'Mauvais mot de passe fourni pour cet utilisateur.';
    }
  }
  return ret;
}

Future<void> AddUser(String email, String nom) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(email)
        .set({'name': nom, 'email': email, 'pts': 0})
        .then((value) => print(""))
        .catchError((error) => print(""));

//    users.doc(email).collection("previsions");
  } catch (e) {}
}
