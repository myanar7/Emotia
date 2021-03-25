import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class LeaderboardScreen extends StatelessWidget {
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
    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            '| | WINNER | |',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Color.fromRGBO(212, 178, 135, 1),
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: ColorsAll.gradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Center(
                      child: Text(
                    GameManager.players[0].playerName.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        wordSpacing: 5),
                  ))),
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Widgets.playerProfile('', 75,
                        GameManager.players[0].avatarNo, Colors.amberAccent),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('Assets/Icons/winner.png'),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: player(GameManager.players, 50),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                      child: Widgets.greenButton(50, Icons.repeat, () {
                    GameManager.refresh();
                    Navigator.of(context).pushReplacementNamed(('/addPlayer'));
                  }))),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> player(List<Player> players, double radius) {
  List<Widget> temp = List<Widget>();
  temp.add(Center(
    child: Widgets.playerProfile(
        players[1].playerName, radius, players[1].avatarNo, Colors.grey),
  ));
  if (GameManager.players.length > 2)
    temp.add(Center(
      child: Widgets.playerProfile(
          players[2].playerName, radius, players[2].avatarNo, Colors.brown),
    ));
  return temp;
}
