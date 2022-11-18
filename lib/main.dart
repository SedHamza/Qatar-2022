// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, unnecessary_new

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet1/Home.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) {
        return User_Provider();
      }),
      ChangeNotifierProvider(create: (context) {
        return Team_provider();
      }),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static Team_provider provider = new Team_provider();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);

    User_Provider User_Prov = Provider.of<User_Provider>(context);
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word Cup Qatar 2022',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );
  }
}
