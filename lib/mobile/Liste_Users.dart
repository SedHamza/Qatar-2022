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
  List<Usr> user = [];

  @override
  void initState() {
    User_Provider User_Prov =
        Provider.of<User_Provider>(context, listen: false);
    User_Prov.users.sort(
      (b, a) {
        if (a.pts == b.pts) {
          return (-a.taw.length).compareTo(-(b.taw.length));
        }
        return a.pts.compareTo(b.pts);
      },
    );
    user = User_Prov.users;
  }

  @override
  Widget build(BuildContext context) {
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
              children: List.generate(user.length, (index) {
                return UsersItems(user[index], index, true);
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
