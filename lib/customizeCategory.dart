import 'dart:math';
import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'Assignment.dart';
import 'colors.dart';

class CustomizeCategory extends StatefulWidget {
  @override
  _CustomizeCategoryState createState() => _CustomizeCategoryState();
}

class _CustomizeCategoryState extends State<CustomizeCategory>
    with TickerProviderStateMixin {
  List<Assignment> welcomeImages = List<Assignment>();
  List<Assignment> selected = List<Assignment>();
  List<Assignment> allMoviesSeen = List<Assignment>();
  Color buttonColor;
  IconData iconData;
  int direction;
  int leftAssignment;

  @override
  void initState() {
    //AYNI FİLM NADİR DE OLSA TEKRAR GELEBLİR NEDENİ 0. İNDİSİ SİLİYOR VE ONDAN BİHABER KALIYOR OLUŞUMUZ
    // TODO: implement initState
    super.initState();
    leftAssignment = GameManager.players.length * 6;
    direction = 0;

    buttonColor = Colors.red.shade900;
    iconData = Icons.close;
  }

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
    final int args = ModalRoute.of(context).settings.arguments; //Category Code

    setState(() {
      int i = 0;
      while (i != 2) {
        if (selected.length == GameManager.players.length * 6 ||
            allMoviesSeen.length == allData[args].length) break;
        bool controller = true;
        Assignment temp1 =
            allData[args].elementAt(Random().nextInt(allData[args].length));
        for (Assignment a in allMoviesSeen) {
          if (a.name == temp1.name) {
            controller = false;
            break;
          }
        }
        if (controller) {
          welcomeImages.add(temp1);
          allMoviesSeen.add(temp1);
        } else
          i--;
        i++;
      }
    });

    CardController controller; //Use this to trigger swap.
    return WillPopScope(
        onWillPop: _backPress,
        child: Scaffold(
            body: Container(
          decoration: BoxDecoration(
            gradient: ColorsAll.gradient,
          ),
          child: Center(
              child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TinderSwapCard(
                    swipeUp: false,
                    swipeDown: false,
                    orientation: AmassOrientation.TOP,
                    totalNum: welcomeImages.length,
                    stackNum: 5,
                    swipeEdge: 5.0,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.width * 0.9,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    minHeight: MediaQuery.of(context).size.width * 0.8,
                    cardBuilder: (context, index) => GestureDetector(
                      child: Card(
                        child: Image.asset(welcomeImages[index].imagePath),
                        elevation: 10,
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        borderOnForeground: true,
                        semanticContainer: true,
                      ),
                    ),
                    cardController: controller = CardController(),
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      /// Get swiping card's alignment
                      if (align.x < 0) {
                        if (direction != -1) {
                          controller.triggerLeft();
                          direction = -1;
                        }
                        //Card is LEFT swiping
                      } else if (align.x > 0) {
                        if (direction != 1) {
                          controller.triggerRight();
                          direction = 1;
                        }
                        //Card is RIGHT swiping
                      }
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      print(welcomeImages.length);
                      if (selected.length != GameManager.players.length * 6) {
                        if (orientation == CardSwipeOrientation.RIGHT) {
                          selected.add(welcomeImages.elementAt(0));
                          leftAssignment--;
                          if (selected.length ==
                              GameManager.players.length * 6) {
                            GameManager.categoryControl.contains(args)
                                ? print('Bu Zaten Vardı')
                                : GameManager.categoryControl.add(args);
                            setState(() {
                              welcomeImages.clear();
                              buttonColor = Colors.green;
                              iconData = Icons.check;
                            });
                          }
                        }
                        setState(() {
                          if (welcomeImages.isNotEmpty) {
                            welcomeImages.removeAt(0);
                          }
                        });
                        print(selected.length);
                        direction = 0;
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "to out  ",
                            style: TextStyle(
                                color: Colors.white70,
                                fontFamily: "Raleway",
                                fontSize: 30,
                                wordSpacing: 5),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.swipe,
                              color: Colors.white60,
                              size: 80,
                            ),
                          ),
                          TextSpan(
                            text: "  to add",
                            style: TextStyle(
                                fontFamily: "Raleway",
                                color: Colors.white70,
                                fontSize: 30,
                                wordSpacing: 5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Remained Assignment: $leftAssignment",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontFamily: "Raleway"),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: turnBack(50, iconData, () {
                      if (selected.length > GameManager.players.length * 6 - 1)
                        GameManager.customized.addAll(selected);
                      Navigator.of(context)
                          .pushReplacementNamed('/createCategory');
                    }, buttonColor),
                  ))
            ],
          )),
        )));
  }

  Widget turnBack(double radius, IconData iconData, void eylem(), Color color) {
    //0 ileri 1 geri
    return ClipOval(
      child: Container(
        height: radius * 5 / 3,
        width: radius * 5 / 3,
        decoration: BoxDecoration(color: color),
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
