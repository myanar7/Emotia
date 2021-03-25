import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class GuesserScreen extends StatefulWidget {
  @override
  _GuesserScreenState createState() => _GuesserScreenState();
}

class _GuesserScreenState extends State<GuesserScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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

    print('Guesser Screem');

    final ScreenArguments args = ModalRoute
        .of(context)
        .settings
        .arguments;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(gradient: ColorsAll.darkColor),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/curtain.png'),
                                  fit: BoxFit.fill)),
                          alignment: Alignment.bottomCenter,
                          child: Center(
                            child: Text(
                              args.data,
                              style: TextStyle(
                                  fontSize:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width / 10),
                            ),
                          ),
                        ),
                        Text(
                          'What ${GameManager.categoryName(GameManager.assignment.category)} Is It ?',
                          style: TextStyle(color: Colors.white70, fontSize: 25),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: textController,
                            scrollPadding: EdgeInsets.only(left: 30, right: 30),
                            cursorColor: Colors.lightGreen,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Your Estimate',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Widgets.greenButton(50, Icons.play_arrow, () {
                            Navigator.of(context).pushReplacementNamed(
                                '/checkPage',
                                arguments: ScreenArguments(
                                    args.data, textController.text));
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}