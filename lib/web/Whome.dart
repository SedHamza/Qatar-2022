// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, file_names, non_constant_identifier_names, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/firebase/addTawaqoa.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:projet1/web/CenterWigets.dart';
import 'package:projet1/web/WListeMatch.dart';
import 'package:projet1/web/WLogin_Regi.dart';
import 'package:projet1/web/groupeListe.dart';
import 'package:provider/provider.dart';

class WHome extends StatefulWidget {
  const WHome({super.key});

  @override
  State<WHome> createState() => _WHomeState();
}

class _WHomeState extends State<WHome> {
  Team_provider provider = Team_provider();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);
    User_Provider User_Prov = Provider.of<User_Provider>(context);
    for (var element in User_Prov.users) {
      int pts = 0;
      for (var elem in element.taw) {
        int pt = comptePts(elem);
        pts += pt;
        if (pt != elem.pts) {
          elem.pts = pt;
          UpdateTaw(elem.id, pt, element.email);
        }
      }
      element.pts = pts;
      UpdatePTS(pts, element.email);
    }
    return Scaffold(
        appBar: appBar(),
        body: (provider.matchs.data.isNotEmpty)
            ? Container(
                child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Container(
                          child: WListeMatch(),
                        ),
                      )),
                  VerticalDivider(
                    indent: 10,
                    endIndent: 10,
                    width: 0.0,
                    color: MyColors.firsteColor,
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Container(
                          child: CenterPage(),
                        ),
                      )),
                  VerticalDivider(
                    indent: 10,
                    endIndent: 10,
                    width: 0,
                    color: MyColors.firsteColor,
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Container(
                          child: WGroupes(),
                        ),
                      )),
                ],
              ))
            : Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    color: MyColors.firsteColor,
                  ),
                ),
              ));
  }

  AppBar? appBar() {
    return AppBar(
      title: Text(
        "Coupe Du Monde Qatar 2022",
        style: TextStyle(
            color: MyColors.secondColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      leading: InkWell(
        onTap: () {
          provider.getDataTeam();
        },
        child: Icon(Icons.update_outlined),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            focusColor: Colors.amber,
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return WLogin();
              }));
            },
            child: Icon(
              Icons.logout,
              color: MyColors.secondColor,
            ),
          ),
        )
      ],
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(10, 20),
                bottomRight: Radius.elliptical(10, 20)),
            color: MyColors.firsteColor),
      ),
    );
  }
}
