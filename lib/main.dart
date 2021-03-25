import 'package:ea/assignmentScreen.dart';
import 'package:ea/categoryScreen.dart';
import 'package:ea/checkPage.dart';
import 'package:ea/createAccount.dart';
import 'package:ea/createCategory.dart';
import 'package:ea/customizeCategory.dart';
import 'package:ea/guesserScreen.dart';
import 'package:ea/introductionScreen.dart';
import 'package:ea/jobScreen.dart';
import 'package:ea/leaderboardScreen.dart';
import 'package:ea/markerScreen.dart';
import 'package:ea/playScreen.dart';
import 'package:ea/playerAdd.dart';
import 'package:ea/splash.dart';
import 'package:ea/turnScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        accentColor: Colors.lightGreen,
        fontFamily: "Raleway",
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: {
        'playScreen': (context) => PS(),
        '/categoryScreen': (context) => CategoryScreen(),
        '/customizeCategory': (context) => CustomizeCategory(),
        '/createCategory': (context) => CreateCategory(),
        '/turnScreen': (context) => TurnScreen(),
        '/jobScreen': (context) => JobScreen(),
        '/addPlayer': (context) => PlayerAdd(),
        '/createAccount': (context) => CreateAccount(),
        '/markerScreen': (context) => MarkerScreen(),
        '/checkPage': (context) => CheckPage(),
        '/guesserScreen': (context) => GuesserScreen(),
        '/assignmentScreen': (context) => AssignmentScreen(),
        '/leaderboardScreen': (context) => LeaderboardScreen(),
      },
    ),
  );
}
