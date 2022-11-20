// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, must_call_super, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/compopente/UserItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    User_Provider User_Prov = Provider.of<User_Provider>(context);
    return Scaffold(
      appBar: appBar(),
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: List.generate(User_Prov.users.length, (index) {
                return UsersItems(User_Prov.users[index], index, true);
              }),
            ),
          ),
        ),
      ),
    );
  }

  AppBar? appBar() {
    return AppBar(
      title: Text(
        "Les Meilleurs Joueurs",
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
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(10, 20),
                bottomRight: Radius.elliptical(10, 20)),
            color: MyColors.firsteColor),
      ),
    );
  }
}
