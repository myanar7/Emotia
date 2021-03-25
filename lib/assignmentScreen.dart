import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class AssignmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
                        label:
                            Text("No", style: TextStyle(color: Colors.white)),
                      ),
                      FlatButton.icon(
                          onPressed: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) => PS()));
                          },
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          label: Text("Yes",
                              style: TextStyle(color: Colors.white)))
                    ],
                  )
                ],
              ),
            );
          });
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    print('Assignment Screen');
    return Scaffold(
      body: WillPopScope(
        onWillPop: _backPress,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: ColorsAll.gradient),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: Image(
                      image: AssetImage(GameManager.assignment.imagePath)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "${GameManager.assignment.name}"
                      ""
                      "",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Describe this by using emojies!"
                      "",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: Widgets.greenButton(50, Icons.play_arrow, () {
                        Navigator.of(context)
                            .pushReplacementNamed('/markerScreen');
                      }),
                    ),
                    Center(
                      child: redButton(
                        50,
                        Icons.skip_next,
                        () {
                          GameManager.roundUp();
                          if (GameManager.round == GameManager.players.length)
                            GameManager.setJobs();
                          if (GameManager.round ==
                              (GameManager.players.length * 3)) {
                            GameManager.sortPlayers();
                            Navigator.of(context)
                                .pushReplacementNamed('/leaderboardScreen');
                          } else
                            Navigator.of(context)
                                .pushReplacementNamed('/jobScreen');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget redButton(double radius, IconData iconData, void eylem()) {
    //0 ileri 1 geri
    return ClipOval(
      child: Container(
        height: radius * 5 / 3,
        width: radius * 5 / 3,
        decoration: BoxDecoration(color: Colors.redAccent.shade700),
        child: FlatButton(
            onPressed: () {
              eylem();
            },
            padding: EdgeInsets.zero,
            child: Icon(
              iconData,
              size: radius * 6 / 5,
              color: Colors.white,
            )),
      ),
    );
  }
}
