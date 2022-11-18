// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, avoid_print, file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/firebase/authentification/authrntification.dart';
import 'package:projet1/splash_Screen.dart';
import 'package:projet1/web/Whome.dart';

class WLogin extends StatefulWidget {
  const WLogin({super.key});

  @override
  State<WLogin> createState() => _WLoginState();
}

class _WLoginState extends State<WLogin> {
  final email = TextEditingController();
  final name = TextEditingController();
  final pass = TextEditingController();
  final Cpass = TextEditingController();
  String erreurEmail = "";
  String erreurName = "";
  String erreurpass = "";
  String erreurCpass = "";
  String erreur = "";
  bool ncompte = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.firsteColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            child: Image.asset('assets/Logo.png'),
                          ),
                        )),
                    Expanded(
                      flex: 4,
                      child: Card(
                        elevation: 30,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 5),
                              child: Text(
                                ncompte ? "Nouveux Compte" : "Se Connecter",
                                style: TextStyle(
                                    color: MyColors.firsteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            ncompte
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Nome(),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Email(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: password(),
                            ),
                            ncompte
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: confirmePaswword(),
                                  )
                                : Container(),
                            Text(
                              erreur,
                              style: TextStyle(color: Colors.red),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          ncompte = !ncompte;
                                        });
                                      },
                                      child: Text(
                                        ncompte
                                            ? "Avez vous déjà un compte?"
                                            : "Nouveau Compte? ",
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  InkWell(
                                    onTap: send,
                                    child: Card(
                                      color: MyColors.firsteColor,
                                      elevation: 2,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Envoyée",
                                              style: TextStyle(
                                                  color: MyColors.secondColor),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_right_sharp,
                                            size: 40,
                                            color: MyColors.secondColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void send() async {
    setState(() {
      erreurEmail = "";
      erreurName = "";
      erreurpass = "";
      erreurCpass = "";
      erreur = "";
    });
    if (ncompte) {
      if (name.text.isNotEmpty) {
        if (email.text.indexOf("@") < email.text.lastIndexOf(".")) {
          if (pass.text == Cpass.text) {
            erreur = await createAcount(email.text, pass.text, name.text);

            setState(() {
              erreur = erreur;
            });
            if (erreur == "Good") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Splash_Screen();
              }));
            }
          } else {
            setState(() {
              setState(() {
                erreurCpass = "Les Mots De Passe Ne Sont Pas Identiques";
              });
            });
          }
        } else {
          setState(() {
            erreurEmail = "Email invalides";
          });
        }
      } else {

        erreurName = "Entrer votre Nome";
      }
    } else {
      if (email.text.isNotEmpty) {
        if (pass.text.isNotEmpty) {
          erreur = await login(email.text, pass.text);
          setState(() {});
          if (erreur == "Good") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return WHome();
            }));
          }
        } else {
          erreurpass = "Entrer le mot de passe";
        }
      } else {
        erreurEmail = "Entrer e-mail";
      }
    }
  }

  Widget Email() {
    return TextField(
      controller: email,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: MyColors.firsteColor,
        ),
        hintText: 'Email',
        errorText: erreurEmail == "" ? null : erreurEmail,
        labelText: 'Email',
      ),
    );
  }

  Widget Nome() {
    return TextField(
      controller: name,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: MyColors.firsteColor,
        ),
        hintText: 'Nom',
        errorText: erreurName == "" ? null : erreurName,
        labelText: 'Nom',
      ),
    );
  }

  Widget password() {
    return TextField(
      controller: pass,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        prefixIcon: Icon(
          Icons.password_outlined,
          color: MyColors.firsteColor,
        ),
        hintText: 'Le Mote De Passe',
        errorText: erreurpass == "" ? null : erreurpass,
        labelText: 'Le Mote De Passe',
      ),
    );
  }

  Widget confirmePaswword() {
    return TextField(
      controller: Cpass,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        prefixIcon: Icon(
          Icons.password_outlined,
          color: MyColors.firsteColor,
        ),
        hintText: 'Confirmez Le Mot De Passe',
        errorText: erreurCpass == "" ? null : erreurCpass,
        labelText: 'Confirmez Le Mot De Passe',
      ),
    );
  }
}
