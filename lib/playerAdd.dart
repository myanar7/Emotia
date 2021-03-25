import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ea/playScreen.dart';

import 'colors.dart';

class PlayerAdd extends StatefulWidget {
  @override
  _PlayerAddState createState() => _PlayerAddState();
}

class _PlayerAddState extends State<PlayerAdd> {
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
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => PS()));
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    Navigator.of(context).reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'EMOTIA',
            style: TextStyle(
              color: Colors.white, fontSize: 30,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(212, 178, 135, 1),
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: _backPress,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: ColorsAll.gradient),
            child: Stack(
              overflow: Overflow.visible,
              fit: StackFit.expand,
              children: <Widget>[
                GridView.builder(
                  itemCount: GameManager.players.length + 1,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    if (index != GameManager.players.length)
                      return Widgets.playerProfile(
                          GameManager.players[index].playerName,
                          50,
                          GameManager.players[index].avatarNo,
                          null);
                    if (index != 8) {
                      return IconButton(
                          icon: Image.asset('Assets/Icons/addIcon.png'),
                          iconSize: 50,
                          onPressed: () {
                            setState(() {
                              Navigator.of(context)
                                  .pushReplacementNamed('/createAccount');
                            });
                          });
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                Positioned(
                  bottom: 50,
                  left: 130,
                  child: Widgets.greenButton(
                      (() {
                        if (GameManager.players.length < 2)
                          return 0.0;
                        else
                          return 50.0;
                      })(),
                      Icons.play_arrow,
                      () {
                        GameManager.setJobs();
                        GameManager.assignment = null;
                        Navigator.of(context)
                            .pushReplacementNamed('/categoryScreen');
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
