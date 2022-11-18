// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, file_names, unused_import, avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet1/constante/device_Size.dart';
import 'package:projet1/firebase/addTawaqoa.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/mobile/Login_Regi.dart';
import 'package:projet1/mobile/Mhome.dart';
import 'package:projet1/mobile/groupeListe.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:projet1/splash_Screen.dart';
import 'package:projet1/web/WLogin_Regi.dart';
import 'package:projet1/web/Whome.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLogin = false;
  @override
  void initState() {
    isLogin = FirebaseAuth.instance.currentUser != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Scrinetype.setSize(MediaQuery.of(context).size.width);
    if (Scrinetype.isWeb) {
      return isWeb();
    }
    if (Scrinetype.isMobile) {
      return isMobile();
    }
    return Scaffold(
      body: Container(
          child: Center(
        child: Text(Scrinetype.width.toString()),
      )),
    );
  }

  Widget isWeb() {
    return isLogin ? Splash_Screen() : WLogin();
  }

  Widget isMobile() {
    return isLogin ? Splash_Screen() : Login();
  }
}
