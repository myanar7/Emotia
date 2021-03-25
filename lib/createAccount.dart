import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController _controller = TextEditingController();
  String avatarKarakterDeger = "";
  int maxLength = 9; //INPUTA YAZILAN KARAKTER SAYISI
  int avatarNo = 1;
  String avatarAdress = 'Assets/Images/Avatars/avatar1.jpg';

  @override
  void dispose() {
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

    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(212, 178, 135, 1),
            elevation: 0,
            title: Center(
                child: Text(
                  "EMOTIA",
                  style: TextStyle(
                    color: Colors.white, fontSize: 30,
                    //fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: ColorsAll.gradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Image.asset(
                    avatarAdress,
                    height: 100,
                    width: 100,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: avatars(1, 15),
                    ),
                    Expanded(
                      child: avatars(2, 15),
                    ),
                    Expanded(
                      child: avatars(3, 15),
                    ),
                    Expanded(
                      child: avatars(4, 15),
                    ),
                    Expanded(
                      child: avatars(5, 15),
                    ),
                    Expanded(
                      child: avatars(6, 15),
                    ),
                  ],
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _controller,
                  onChanged: (String yeniDeger) {
                    if (yeniDeger.length <= maxLength) {
                      avatarKarakterDeger = yeniDeger;
                    } else {
                      _controller.value = TextEditingValue(
                        text: avatarKarakterDeger,
                        selection: TextSelection(
                          baseOffset: maxLength,
                          extentOffset: maxLength,
                          affinity: TextAffinity.downstream,
                          isDirectional: false,
                        ),
                        composing: TextRange(
                          start: 0,
                          end: maxLength,
                        ),
                      );
                      _controller.text = avatarKarakterDeger;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Player Name',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Player Name',
                    hintStyle: TextStyle(fontSize: 20, color: Colors.white24),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Align(
                        alignment: Alignment.center,
                        child: Widgets.greenButton(50, Icons.play_arrow, () {
                          if (_controller.text != '')
                            GameManager.addPlayer(
                                Player(_controller.text, avatarNo));
                          Navigator.of(context)
                              .pushReplacementNamed('/addPlayer');
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget avatars(int index, double radius) {
    return ClipOval(
      child: FlatButton(
        onPressed: () {
          setState(() {
            avatarNo = index;
            avatarAdress =
                'Assets/Images/Avatars/avatar' + index.toString() + '.jpg';
          });
        },
        child: Widgets.avatars(index, radius, null),
      ),
    );
  }
}
