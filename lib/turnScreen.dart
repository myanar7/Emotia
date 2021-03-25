import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class TurnScreen extends StatelessWidget {
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    print('Turn Screen');
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
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: playerProfile(),
                ),
              ),
              Expanded(
                  child: Center(
                child: Text(
                  () {
                    if (GameManager.gameTurn ==
                        0) // if(GameManager.round%GameManager.players.length==GameManager.gameTurn%GameManager.players.length) bunu markeri geçerken kullan
                      return 'You are the Marker\n\nBe Ready ';
                    return 'You are Guesser';
                  }(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
              Expanded(
                flex: 3,
                child: Center(
                  child: Widgets.greenButton(50, Icons.play_arrow, () {
                    if (GameManager.gameTurn ==
                        0) //HER OYUN İÇİ TURDA gameTurn ++
                      Navigator.of(context)
                          .pushReplacementNamed('/assignmentScreen');
                    else
                      Navigator.of(context).pushReplacementNamed(
                          '/guesserScreen',
                          arguments: ScreenArguments(args.data, ''));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playerProfile() {
    if (GameManager.gameTurn == 0) {
      print('buraya girdik aloıoooooo');

      return Widgets.playerProfile(
          GameManager.marker.playerName, 50, GameManager.marker.avatarNo, null);
    } else
      return Widgets.playerProfile(
          GameManager
              .guessers[
                  (GameManager.gameTurn - 1) % GameManager.guessers.length]
              .playerName,
          50,
          GameManager
              .guessers[
                  (GameManager.gameTurn - 1) % GameManager.guessers.length]
              .avatarNo,
          null);
  }
} /////////BURAYA BİR BAK BU INDEX DÜZGÜN ÇALIŞMIYOR ÇÜNKÜ SAYIYI AŞIYOR
////////////////////////////          YANİ SONUC OLARAK EBE OLAN KİŞİYİ ATLAYIP DİĞER KİŞİLERİ GÖSTERMESİ LAZIM
