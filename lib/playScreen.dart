import 'dart:io';
import 'package:ea/introductionScreen.dart';
import 'package:ea/playerAdd.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_buttons/social_media_buttons.dart';

class PS extends StatefulWidget {
  @override
  _PSState createState() => _PSState();
}

class _PSState extends State<PS> with TickerProviderStateMixin {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  Future<bool> _backPress() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: AlertDialog(
              contentPadding: EdgeInsets.all(20),
              backgroundColor: Colors.transparent,
              elevation: 0,
              titlePadding: EdgeInsets.all(20),
              title: Text(
                "Do you really want to exit application?",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      label: Text("No", style: TextStyle(color: Colors.white)),
                    ),
                    FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            exit(0);
                          });
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        label:
                            Text("Yes", style: TextStyle(color: Colors.white)))
                  ],
                )
              ],
            ),
          );
        });
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPress,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            /* begin: Alignment.topRight,
            end: Alignment.bottomLeft,*/

            colors: [
              Color.fromRGBO(212, 178, 135, 1),
              Color.fromRGBO(212, 178, 135, 1),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "EMOTIA",
              style: TextStyle(
                //   fontFamily: "Deneme4",
                color: Colors.white,
                //     fontWeight: FontWeight.w700,
                fontSize: 35,
              ),
            ),
            backgroundColor: Color(0x00000000),
            elevation: 0.0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    "Assets/splash.png",
                    fit: BoxFit.cover,
                  ),
                  width: 300,
                  height: 300,
                ),
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(milliseconds: 500),
                  child: Widgets.greenButton(
                    50,
                    Icons.play_arrow,
                    () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => PlayerAdd()));
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton.icon(
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => IS()));
                        },
                        icon: Icon(
                          Icons.library_books,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Instructions",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: Duration(milliseconds: 1500),
                      child: SocialMediaButton.instagram(
                        url: "https://instagram.com/mustafayanar7",
                        size: 35,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
