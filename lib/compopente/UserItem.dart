// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/mobile/UserView.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';

class UsersItems extends StatefulWidget {
  Usr user;
  int index;
  bool clicked;
  UsersItems(this.user, this.index, this.clicked);

  @override
  State<UsersItems> createState() => _UsersItemsState();
}

class _UsersItemsState extends State<UsersItems> {
  User_Provider User_Prov = User_Provider();
  List<Color> clrs = [
    Colors.amber,
    Color.fromARGB(255, 165, 134, 11),
    Color.fromARGB(255, 121, 118, 118)
  ];
  bool isHoverd = false;

  @override
  Widget build(BuildContext context) {
    User_Prov = Provider.of<User_Provider>(context);

    return InkWell(
      onTap: () {
        if (widget.clicked) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserView(widget.user, widget.index);
          }));
        }
      },
      onFocusChange: ((value) {
        setState(() {
          isHoverd = !isHoverd;
        });
      }),
      child: Container(
        child: Card(
          color: isHoverd ? Colors.blue : MyColors.secondColor,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Container(
              color: MyColors.secondColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (widget.index + 1).toString(),
                      style: TextStyle(
                          color: (widget.index <= 2)
                              ? clrs[widget.index]
                              : MyColors.firsteColor,
                          fontSize: 25,
                          fontStyle: FontStyle.italic),
                    ),
                    VerticalDivider(
                      color: MyColors.firsteColor,
                      thickness: 2,
                    ),
                    Icon(
                      Icons.person,
                      color: (widget.index <= 2)
                          ? clrs[widget.index]
                          : MyColors.firsteColor,
                      size: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.user.nom,
                                  style: TextStyle(
                                    color: (widget.index <= 2)
                                        ? clrs[widget.index]
                                        : MyColors.firsteColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.user.pts.toString() +
                                      " Pts / " +
                                      widget.user.taw.length.toString() +
                                      " Matchs",
                                  style: TextStyle(
                                    color: (widget.index <= 2)
                                        ? clrs[widget.index]
                                        : MyColors.firsteColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
