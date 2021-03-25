import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'emoji_picker_customized/emoji_picker.dart';

class MarkerScreen extends StatefulWidget {
  @override
  _MarkerScreenState createState() => _MarkerScreenState();
}

class _MarkerScreenState extends State<MarkerScreen> {
  String data = '';
  List<int> list = List<int>();
  int emojisayisi = 0;
  int row = 4;
  int column = 6;

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
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => PS(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
    print('Marker Screen');

    switch ((MediaQuery.of(context).size.height / 100).floor()) {
      case 2:
      case 3:
        row = 2;
        break;
      case 4:
      case 5:
      case 6: //ORANI KULLAN YÜKSEKLİĞİ DEĞİL
        row = 3;
        break;
      case 7:
      case 8:
        row = 5;
        break;
      default:
        row = 6;
        break;
    }
    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        image: DecorationImage(
                            image: AssetImage('Assets/curtain.png'),
                            fit: BoxFit.fill)),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                            flex: 4,
                            child: Center(
                              child: Text(
                                data,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 10),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: FittedBox(
                              child: Align(
                                alignment: Alignment.center,
                                child: Widgets.greenButton(50, Icons.play_arrow,
                                    () {
                                  GameManager.gameTurnUp();
                                  Navigator.of(context).pushReplacementNamed(
                                      '/turnScreen',
                                      arguments: ScreenArguments(data, ''));
                                }),
                              ),
                            ))
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: EmojiPicker(
                    indicatorColor: Colors.lightGreen,
                    bgColor: Colors.black,
                    onPressDelete: () {
                      //Teyfik Kaşlıca Adam Mıdır ????????
                      setState(() {
                        if (data.length > 0 && list.length != 1) {
                          //Eğer silincek emooji yoksa silme işlemi olmasın diye if else
                          emojisayisi--;
                          data = data.substring(
                              0,
                              data.length -
                                  list[list.length -
                                      1]); //Burası Her Basışta Siliyor
                          list.removeLast();
                        } else if (list.length == 1) {
                          emojisayisi = 0;
                          data = '';
                        }
                      });
                    },
                    rows: row,
                    columns: column,
                    numRecommended: 10,
                    onEmojiSelected: (emoji, category) {
                      setState(() {
                        if (emojisayisi < 5) {
                          emojisayisi++;
                          data += emoji.emoji;
                          list.add(emoji.emoji.length);
                        } else
                          return;
                      });
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
