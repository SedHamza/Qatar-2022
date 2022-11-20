// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet1/compopente/groupeItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';

class WGroupes extends StatefulWidget {
  const WGroupes({super.key});

  @override
  State<WGroupes> createState() => _WGroupesState();
}

class _WGroupesState extends State<WGroupes> {
  late Team_provider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);

    return Scaffold(
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
                    children: List.generate(8, (index) => GroupeItem(index,true)),
                  ),
                )),
    );
  }
}
