// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, sized_box_for_whitespace, avoid_unnecessary_containers, file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, unused_import, duplicate_import, deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_radio_type.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/tawaqoa.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/constante/device_Size.dart';

import 'package:projet1/firebase/addTawaqoa.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';

class Match_prediction extends StatefulWidget {
  Match match;
  String? email;
  Match_prediction(this.match, this.email);

  @override
  State<Match_prediction> createState() => _Match_predictionState();
}

class _Match_predictionState extends State<Match_prediction> {
  User_Provider user_Prov = User_Provider();
  int homeEx = -1;
  int awayEx = -1;
  int mxBut = -1;
  int mnBut = -1; // max but marque
  int quiG = -1; //0 si egalite 1 : home - 2: away
  bool isStarted = false;
  Tawa9oa tawa9oa = Tawa9oa(-1, -1, -1, -1, -1, -1, 0);

  @override
  void initState() {
    User_Provider user_Prov =
        Provider.of<User_Provider>(context, listen: false);
    var user =
        user_Prov.users.firstWhere((element) => element.email == widget.email);
    if (user.taw.where((element) => element.id == widget.match.id).isNotEmpty) {
      tawa9oa =
          user.taw.where((element) => element.id == widget.match.id).first;
      homeEx = tawa9oa.homeEx!;
      awayEx = tawa9oa.awayEx!;
      mxBut = tawa9oa.maxBut!;
      mnBut = tawa9oa.minBut!;
      quiG = tawa9oa.qagne!;
    }
    isStarted = isStareMatch(widget.match);
    if (tawa9oa.id != -1) {
      int pt = comptePts(tawa9oa);
      if (pt != tawa9oa.pts) {
        tawa9oa.pts = pt;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user_Prov = Provider.of<User_Provider>(context);
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            headTawa9o3at(),
            Divider(
              color: MyColors.firsteColor,
              height: 5,
              thickness: 1,
              indent: 8,
              endIndent: 15,
            ),
            SizedBox(
              height: 5,
            ),
            bodyTawa9o3at()
          ],
        ),
      ),
    );
  }

  Widget headTawa9o3at() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Prédiction De Match",
              style: TextStyle(
                  fontSize: 17,
                  color: MyColors.firsteColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              tawa9oa.pts.toString() + "/" + maxPts().toString() + " Pts",
              style: TextStyle(
                  fontSize: 17,
                  color: MyColors.firsteColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyTawa9o3at() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: exactResult(),
          ),
          Divider(
            color: MyColors.firsteColor,
            height: 5,
            indent: 10,
            endIndent: 10,
          ),
          (homeEx == -1 && awayEx == -1)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrinetype.isWeb ? maxButTV() : maxBut(),
                )
              : Container(),
          (homeEx == -1 && awayEx == -1)
              ? Divider(
                  color: MyColors.firsteColor,
                  height: 5,
                  indent: 10,
                  endIndent: 10,
                )
              : Container(),
          (homeEx == -1 && awayEx == -1)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrinetype.isWeb ? MinButTV() : MinBut(),
                )
              : Container(),
          (homeEx == -1 && awayEx == -1)
              ? Divider(
                  color: MyColors.firsteColor,
                  height: 5,
                  indent: 10,
                  endIndent: 10,
                )
              : Container(),
          (homeEx == -1 && awayEx == -1)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrinetype.isWeb ? quiGagneTV() : quiGagne(),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          button(),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget exactResult() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Résultat Exacte ",
                style: TextStyle(
                  fontSize: 15,
                  color: MyColors.firsteColor,
                ),
              ),
              Text(
                "25 Pts",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyColors.firsteColor,
                ),
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                focusColor: MyColors.HoverColor,
                child: Icon(Icons.arrow_drop_up_outlined),
                onTap: () {
                  if (!isStarted) {
                    if (homeEx == -1) {
                      setState(() {
                        awayEx++;
                      });
                    }
                    setState(() {
                      homeEx++;
                    });
                  }
                },
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 18,
                child: CircleAvatar(
                  radius: 17.0,
                  backgroundImage: NetworkImage(widget.match.homeFlag),
                  backgroundColor: Colors.transparent,
                ),
              ),
              InkWell(
                focusColor: MyColors.HoverColor,
                child: Icon(Icons.arrow_drop_down_outlined),
                onTap: () {
                  if (!isStarted) {
                    if (homeEx >= 0) {
                      setState(() {
                        homeEx--;
                        if (homeEx == -1) {
                          awayEx = -1;
                        }
                      });
                    }
                  }
                },
              ),
            ],
          ),
          (homeEx == -1 || awayEx == -1)
              ? Container()
              : Text(
                  homeEx.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.firsteColor,
                  ),
                ),
          Text(
            "-",
            style: TextStyle(
              fontSize: 15,
              color: MyColors.firsteColor,
            ),
          ),
          (homeEx == -1 || awayEx == -1)
              ? Container()
              : Text(
                  awayEx.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.firsteColor,
                  ),
                ),
          Column(
            children: [
              InkWell(
                focusColor: MyColors.HoverColor,
                child: Icon(Icons.arrow_drop_up_outlined),
                onTap: () {
                  if (!isStarted) {
                    setState(() {
                      if (awayEx == -1) {
                        setState(() {
                          homeEx++;
                        });
                      }
                      setState(() {
                        awayEx++;
                      });
                    });
                  }
                },
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 18,
                child: CircleAvatar(
                  radius: 17.0,
                  backgroundImage: NetworkImage(widget.match.awayFlag),
                  backgroundColor: Colors.transparent,
                ),
              ),
              InkWell(
                focusColor: MyColors.HoverColor,
                child: Icon(Icons.arrow_drop_down_outlined),
                onTap: () {
                  if (!isStarted) {
                    if (awayEx >= 0) {
                      if (awayEx >= 0) {
                        setState(() {
                          awayEx--;
                          if (awayEx == -1) {
                            homeEx = -1;
                          }
                        });
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !isStarted
            ? InkWell(
                onTap: () {
                  setState(() {
                    homeEx = -1;
                    awayEx = -1;
                    mxBut = -1;
                    mnBut = -1;
                    quiG = -1;
                  });
                },
                focusColor: MyColors.HoverColor,
                child: Card(
                  color: MyColors.firsteColor,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          "Effacer",
                          style: TextStyle(color: MyColors.secondColor),
                        ),
                        Icon(
                          Icons.close,
                          size: 40,
                          color: MyColors.secondColor,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
        !isStarted
            ? InkWell(
                focusColor: MyColors.HoverColor,
                onTap: () {
                  if (!isStareMatch(widget.match)) {
                    addPere(
                        [homeEx, awayEx, mxBut, mnBut, quiG], widget.match.id);
                    changeT();
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.TOPSLIDE,
                      dialogType: DialogType.success,
                      title: "Succès",
                      desc: "Les Prédiction sont été envoyées avec succès",
                    ).show();
                  } else {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.TOPSLIDE,
                      dialogType: DialogType.error,
                      title: "Erreur",
                      desc: "Le match est déjà commencé",
                    ).show();
                  }
                },
                child: Card(
                  color: MyColors.firsteColor,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          "Envoyee",
                          style: TextStyle(color: MyColors.secondColor),
                        ),
                        Icon(
                          Icons.arrow_right_outlined,
                          size: 40,
                          color: MyColors.secondColor,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  void changeT() {
    tawa9oa = Tawa9oa(widget.match.id, homeEx, awayEx, mxBut, mnBut, quiG, 0);
    var user = user_Prov.users
        .where((element) =>
            element.email == FirebaseAuth.instance.currentUser?.email)
        .first;
    user.taw.removeWhere((element) => element.id == tawa9oa.id);
    user.taw.add(tawa9oa);
  }

  int maxPts() {
    int mx = 0;
    if (homeEx != -1) {
      return 25;
    }
    if (mxBut != -1) {
      mx = (7 - mxBut) * 2;
    }
    if (mnBut != -1) {
      mx += mnBut * 2;
    }
    if (quiG != -1) {
      mx += 5;
    }
    return mx;
  }

  Widget maxBut() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Max But",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                  Text(
                    mxBut == -1
                        ? "0 Pts"
                        : ((7 - mxBut) * 2).toString() + " Pts",
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.firsteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "N",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GFRadio(
                        type: GFRadioType.blunt,
                        size: GFSize.SMALL,
                        activeBorderColor: GFColors.SUCCESS,
                        value: -1,
                        groupValue: mxBut,
                        onChanged: (value) {
                          if (!isStarted) {
                            setState(() {
                              mxBut = value;
                            });
                          }
                        },
                        inactiveIcon: null,
                        customBgColor: MyColors.firsteColor),
                  ],
                ),
                for (int i = 1; i < 7 && mnBut == -1; i++)
                  Column(
                    children: [
                      Text(
                        i.toString(),
                        style: TextStyle(
                            color: MyColors.firsteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      GFRadio(
                          type: GFRadioType.blunt,
                          size: GFSize.SMALL,
                          activeBorderColor: GFColors.SUCCESS,
                          value: i,
                          groupValue: mxBut,
                          onChanged: (value) {
                            if (!isStarted) {
                              setState(() {
                                mxBut = value;
                              });
                            }
                          },
                          inactiveIcon: null,
                          customBgColor: MyColors.firsteColor),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget maxButTV() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Max But",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                  Text(
                    mxBut == -1
                        ? "0 Pts"
                        : ((7 - mxBut) * 2).toString() + " Pts",
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.firsteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "N",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          mxBut = -1;
                        });
                      },
                      focusColor: MyColors.HoverColor,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mxBut == -1 ? Colors.green : Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: mxBut == -1
                                    ? MyColors.firsteColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (int i = 1; i < 7 && mnBut == -1; i++)
                  Column(
                    children: [
                      Text(
                        i.toString(),
                        style: TextStyle(
                            color: MyColors.firsteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            mxBut = i;
                          });
                        },
                        focusColor: MyColors.HoverColor,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: mxBut == i ? Colors.green : Colors.grey,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mxBut == i
                                      ? MyColors.firsteColor
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget MinButTV() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Min But : ",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                  Text(
                    mnBut == -1 ? "0 Pts" : (mnBut * 2).toString() + " Pts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "N",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          mnBut = -1;
                        });
                      },
                      focusColor: MyColors.HoverColor,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mnBut == -1 ? Colors.green : Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: mnBut == -1
                                    ? MyColors.firsteColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (int i = 1; i < 7 && mxBut == -1; i++)
                  Column(
                    children: [
                      Text(
                        i.toString(),
                        style: TextStyle(
                            color: MyColors.firsteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            mnBut = i;
                          });
                        },
                        focusColor: MyColors.HoverColor,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: mnBut == i ? Colors.green : Colors.grey,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mnBut == i
                                      ? MyColors.firsteColor
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget MinBut() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Min But : ",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                  Text(
                    mnBut == -1 ? "0 Pts" : (mnBut * 2).toString() + " Pts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "N",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GFRadio(
                        type: GFRadioType.blunt,
                        size: GFSize.SMALL,
                        activeBorderColor: GFColors.SUCCESS,
                        value: -1,
                        groupValue: mnBut,
                        onChanged: (value) {
                          if (!isStarted) {
                            setState(() {
                              mnBut = value;
                            });
                          }
                        },
                        inactiveIcon: null,
                        customBgColor: MyColors.firsteColor),
                  ],
                ),
                for (int i = 1; i < 7 && mxBut == -1; i++)
                  Column(
                    children: [
                      Text(
                        i.toString(),
                        style: TextStyle(
                            color: MyColors.firsteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      GFRadio(
                          type: GFRadioType.blunt,
                          size: GFSize.SMALL,
                          activeBorderColor: GFColors.SUCCESS,
                          value: i,
                          groupValue: mnBut,
                          onChanged: (value) {
                            if (!isStarted) {
                              setState(() {
                                mnBut = value;
                              });
                            }
                          },
                          inactiveIcon: null,
                          customBgColor: MyColors.firsteColor),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget quiGagne() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Qui Va Gagne : ",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                  Text(
                    quiG == -1 ? "0 Pts" : "5 Pts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "N",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GFRadio(
                        type: GFRadioType.blunt,
                        size: GFSize.LARGE,
                        activeBorderColor: GFColors.SUCCESS,
                        value: -1,
                        groupValue: quiG,
                        onChanged: (value) {
                          if (!isStarted) {
                            setState(() {
                              quiG = value;
                            });
                          }
                        },
                        inactiveIcon: null,
                        customBgColor: MyColors.firsteColor),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.match.homeTeamEn,
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GFRadio(
                        type: GFRadioType.blunt,
                        size: GFSize.LARGE,
                        activeBorderColor: GFColors.SUCCESS,
                        value: 1,
                        groupValue: quiG,
                        onChanged: (value) {
                          if (!isStarted) {
                            setState(() {
                              quiG = value;
                            });
                          }
                        },
                        inactiveIcon: null,
                        customBgColor: MyColors.firsteColor),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "égalité",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GFRadio(
                        type: GFRadioType.blunt,
                        size: GFSize.LARGE,
                        activeBorderColor: GFColors.SUCCESS,
                        value: 0,
                        groupValue: quiG,
                        onChanged: (value) {
                          if (!isStarted) {
                            setState(() {
                              quiG = value;
                            });
                          }
                        },
                        inactiveIcon: null,
                        customBgColor: MyColors.firsteColor),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.match.awayTeamEn,
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GFRadio(
                        type: GFRadioType.blunt,
                        size: GFSize.LARGE,
                        activeBorderColor: GFColors.SUCCESS,
                        value: 2,
                        groupValue: quiG,
                        onChanged: (value) {
                          if (!isStarted) {
                            setState(() {
                              quiG = value;
                            });
                          }
                        },
                        inactiveIcon: null,
                        customBgColor: MyColors.firsteColor),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget quiGagneTV() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Qui Va Gagne : ",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                  Text(
                    quiG == -1 ? "0 Pts" : "5 Pts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: MyColors.firsteColor,
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "N",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quiG = -1;
                        });
                      },
                      focusColor: MyColors.HoverColor,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: quiG == -1 ? Colors.green : Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: quiG == -1
                                    ? MyColors.firsteColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.match.homeTeamEn,
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quiG = 1;
                        });
                      },
                      focusColor: MyColors.HoverColor,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: quiG == 1 ? Colors.green : Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: quiG == 1
                                    ? MyColors.firsteColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "égalité",
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quiG = 0;
                        });
                      },
                      focusColor: MyColors.HoverColor,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: quiG == 0 ? Colors.green : Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: quiG == 0
                                    ? MyColors.firsteColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.match.awayTeamEn,
                      style: TextStyle(
                          color: MyColors.firsteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quiG = 2;
                        });
                      },
                      focusColor: MyColors.HoverColor,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: quiG == 2 ? Colors.green : Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: quiG == 2
                                    ? MyColors.firsteColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
