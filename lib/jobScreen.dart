import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class JobScreen extends StatefulWidget {
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
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
                          Navigator.push(
                              context, CupertinoPageRoute(builder: (context) => PS()));
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


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: ColorsAll.gradient),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Marker',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Widgets.playerProfile(GameManager.marker.playerName, 50,
                        GameManager.marker.avatarNo, null),
                    Text(
                      'Guessers',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: GameManager.guessers.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Widgets.playerProfile(
                            GameManager.guessers[index].playerName,
                            50,
                            GameManager.guessers[index].avatarNo,
                            null);
                      },
                    ),
                  ],
                ),
                Center(
                    child: Widgets.greenButton(50, Icons.play_arrow, () {
                      GameManager.setRandomAssignment();
                  Navigator.of(context).pushReplacementNamed('/turnScreen');
                })),
              ],
            )),
      ),
    );
  }
}
