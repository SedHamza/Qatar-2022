// ignore_for_file: prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, prefer_const_constructors, prefer_interpolation_to_compose_strings, file_names, sized_box_for_whitespace, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:projet1/compopente/groupeItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';

class Groupes extends StatefulWidget {
  const Groupes({super.key});

  @override
  State<Groupes> createState() => _GroupesState();
}

class _GroupesState extends State<Groupes> {
  late Team_provider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);

    return Scaffold(
      appBar: appBar(),
      body: Container(
          child: provider.classement.data == null
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.firsteColor,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: List.generate(8, (index) => GroupeItem(index)),
                  ),
                )),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Les Groupes",
        style: TextStyle(
            color: MyColors.secondColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            // ignore: prefer_const_constructors
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(10, 20),
                bottomRight: Radius.elliptical(10, 20)),
            color: MyColors.firsteColor),
      ),
    );
  }
}
