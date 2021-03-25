import 'package:avatar_glow/avatar_glow.dart';
import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class CheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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



    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    print('Check Screen');
    bool result =
        (GameManager.checkAnswer(args.guess.toLowerCase())) ? true : false;
    Color check =
        (result) ? Colors.lightGreenAccent.shade700 : Colors.redAccent.shade700;

    for (String s in GameManager.assignment.keyWords) print(s);
    print(args.guess);

    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: ColorsAll.gradient),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Text(
                  'Your Answer Is $result',
                  style: TextStyle(color: Colors.white),
                ),
              )),
              Expanded(
                flex: 4,
                child: Center(
                  child: AvatarGlow(
                    glowColor: check,
                    endRadius: 600,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 0),
                    child: Material(
                      elevation: 25,
                      color: Colors.transparent,
                      child: Widgets.playerProfile(
                          GameManager
                              .guessers[(GameManager.gameTurn - 1) %
                                  GameManager.guessers.length]
                              .playerName,
                          50,
                          GameManager
                              .guessers[(GameManager.gameTurn - 1) %
                                  GameManager.guessers.length]
                              .avatarNo,
                          null),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Widgets.pointNotification(result),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Widgets.greenButton(50, Icons.play_arrow, () {
                    if (result) {
                      switch (
                          (GameManager.gameTurn / GameManager.guessers.length)
                              .ceil()) {
                        case 1:
                          GameManager.guessers[(GameManager.gameTurn - 1) %
                                  GameManager.guessers.length]
                              .increasePoint(10);
                          break;
                        case 2:
                          GameManager.guessers[(GameManager.gameTurn - 1) %
                                  GameManager.guessers.length]
                              .increasePoint(8);
                          break;
                        case 3:
                          GameManager.guessers[(GameManager.gameTurn - 1) %
                                  GameManager.guessers.length]
                              .increasePoint(6);
                          break;
                        default:
                          break;
                      }
                    }
                    GameManager
                        .guessers[(GameManager.gameTurn - 1) %
                            GameManager.guessers.length]
                        .answer = (result) ? true : false;
                    GameManager.gameTurnUp();

                    for (int i = 0;
                        i < GameManager.guessers.length * 3 + 1;
                        i++) {
                      if (GameManager
                              .guessers[(GameManager.gameTurn - 1) %
                                  GameManager.guessers.length]
                              .answer ==
                          true) {
                        GameManager.gameTurnUp();
                        continue;
                      }
                      break;
                    }
                    if (GameManager.gameTurn >
                        (GameManager.guessers.length) * 3) {
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
                    } else
                      Navigator.of(context).pushReplacementNamed('/turnScreen',
                          arguments: ScreenArguments(args.data, args.guess));
                    // Navigator.of(context)..popUntil(ModalRoute.withName('/guesserScreen')); //NORMALDE BU OLACAK
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
