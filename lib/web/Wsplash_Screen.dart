// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/constante/device_Size.dart';
import 'package:projet1/mobile/Mhome.dart';
import 'package:projet1/web/Whome.dart';

class WSplash_Screen extends StatefulWidget {
  WSplash_Screen({Key? key}) : super(key: key);

  @override
  State<WSplash_Screen> createState() => _WSplash_ScreenState();
}

class _WSplash_ScreenState extends State<WSplash_Screen>
    with TickerProviderStateMixin {
  double _fontSize = 0;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 0.4;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 1.5;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 6), () {
      setState(() {
          Navigator.pushReplacement(context, PageTransition(WHome()));

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: MyColors.firsteColor.withOpacity(0.5),
        body: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 1000),
                        opacity: _textOpacity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Image(
                            image: AssetImage(
                              "assets/Logo2.png",
                            ),
                            width: MediaQuery.of(context).size.width / 1.8,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: _height * _fontSize),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          opacity: _containerOpacity,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 2000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: _width / _containerSize,
                            width: _width / _containerSize,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container( child: Image(image: AssetImage("assets/Logo1.png"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 5000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomLeft,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
