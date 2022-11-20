// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, file_names, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print, unused_import, non_constant_identifier_names, dead_code, sized_box_for_whitespace

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/Standings.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/compopente/UserItem.dart';
import 'package:projet1/compopente/bestAtack.dart';
import 'package:projet1/compopente/bestDefender.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/firebase/addTawaqoa.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/main.dart';
import 'package:projet1/mobile/Liste_Users.dart';
import 'package:projet1/mobile/Login_Regi.dart';
import 'package:projet1/mobile/Matchs.dart';
import 'package:projet1/mobile/groupeListe.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';

class MHome extends StatefulWidget {
  const MHome({super.key});

  @override
  State<MHome> createState() => _MHomeState();
}

class _MHomeState extends State<MHome> {
  Team_provider provider = Team_provider();
  User_Provider User_Prov = User_Provider();
  int currentIndex = 0;
  //List<Usr> user = [];
  @override
  Widget build(BuildContext context) {
    User_Provider User_Prov = Provider.of<User_Provider>(context);

    provider = Provider.of<Team_provider>(context);
    List<Widget> Pages = [Home(), Groupes()];
    User_Prov = Provider.of<User_Provider>(context);
    if (provider.matchs.data.isNotEmpty) {
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
        if (element.pts != pts) {
          element.pts = pts;
          UpdatePTS(pts, element.email);
        }
      }
    }
    return Scaffold(
        appBar: appBar(),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Accueil',
              ),
              activeColor: MyColors.firsteColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.list),
              title: Text('Classement'),
              activeColor: MyColors.firsteColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        body: Pages[currentIndex]);
  }

  Widget Home() {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              theBestThree(),
              matchDay(),
              BestAtack(3),
              BestDefence(3)
            ],
          ),
        ),
      ),
    );
  }

  Widget theBestThree() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Les Meilleurs Joueur",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColors.firsteColor),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ListUsers();
                      }));
                    },
                    child: Icon(
                      Icons.open_in_full_rounded,
                      color: MyColors.firsteColor,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              endIndent: 50,
              indent: 8,
              color: MyColors.firsteColor,
            ),
            Column(
              children: List.generate(
                  User_Prov.users.length > 3 ? 3 : User_Prov.users.length,
                  (index) {
                return UsersItems(User_Prov.users[index], index, true);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget matchDay() {
    DateTime now = DateTime.now();
    List<Match> matchs = [];
    if (provider.matchs.data.isNotEmpty) {
      matchs = provider.matchs.data
          .where((element) =>
              element.localDate.day == now.day &&
              element.localDate.month == now.month)
          .toList();
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Les Match D'aujourd'hui",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColors.firsteColor),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MatchsListe();
                      }));
                    },
                    child: Icon(
                      Icons.open_in_full_rounded,
                      color: MyColors.firsteColor,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              endIndent: 50,
              indent: 8,
              color: MyColors.firsteColor,
            ),
            Column(
              children: matchs.isNotEmpty
                  ? List.generate(matchs.length,
                      (index) => MatchItem(matchs[index].id, true))
                  : [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "Aucun Match Aujourd'hui",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: MyColors.firsteColor),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar? appBar() {
    if (currentIndex != 0) {
      return null;
    }
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
          MyApp.provider.getDataTeam();
          User_Prov.getData();
          setState(() {});
          //provider.getDataTeam();
        },
        child: Icon(Icons.update_outlined),
      ),
      actions: [
        InkWell(
          focusColor: Colors.amber,
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Login();
            }));
          },
          child: Icon(
            Icons.logout,
            color: MyColors.secondColor,
          ),
        ),
        SizedBox(
          width: 5,
        ),
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
