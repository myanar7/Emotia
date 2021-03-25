import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screenArguments.dart';
class Widgets {
  static Widget greenButton(double radius, IconData iconData, void eylem()) {
    //0 ileri 1 geri
    return ClipOval(
      child: Container(
        height: radius * 5 / 3,
        width: radius * 5 / 3,
        decoration: BoxDecoration(color: Colors.lightGreen),
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

  static Widget avatars(int sayi, double radius, Color color) {
    //Avatarlar İçin
    return CircleAvatar(
      backgroundColor: (color != null) ? color : Colors.grey,
      radius: radius,
      child: CircleAvatar(
        backgroundImage: AssetImage('Assets/Images/Avatars/avatar$sayi.jpg'),
        radius: radius * 10 / 11,
      ),
    );
  }

  static Widget playerProfile(
      String userName, double radius, int playerNum, Color color) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          avatars(playerNum, radius, color),
          Text(
            userName,
            style: TextStyle(color: Colors.white, fontSize: radius / 3),
          )
        ],
      ),
    );
  }

  static Widget pointNotification(bool result) {
    return Text(() {
      if (result) {
        String point = '';
        switch ((GameManager.gameTurn / GameManager.guessers.length).ceil()) {
          case 1:
            point = '10';
            break;
          case 2:
            point = '8';
            break;
          case 3:
            point = '6';
            break;
          default:
            break;
        }
        return 'You Earned ' + point + ' Points ! ';
      }
      return 'Try Again !';
    }(),
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center);
  }
}
