import 'package:ea/colors.dart';
import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'Assignment.dart';

class CreateCategory extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

// MUSTAA KANSIZ MIDIR????
class _CreateCategoryState extends State<CreateCategory> {
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
  Widget build(BuildContext context) {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CHOOSE CUSTOMIZE',
                style: TextStyle(
                  color: Colors.white, fontSize: 30,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Color.fromRGBO(212, 178, 135, 1),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: ColorsAll.gradient,
          ),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          //  color: Colors.grey,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  height: 350,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categories(context),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Widgets.greenButton(50, Icons.play_arrow, () {
                      Navigator.of(context).pushReplacementNamed('/jobScreen');
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget categoryButton(double radius, IconData iconData, void eylem()) {
  //0 ileri 1 geri
  return ClipOval(
    child: Container(
      height: radius * 5 / 3,
      width: radius * 5 / 3,
      decoration: BoxDecoration(color: Colors.yellow.shade600),
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

List<Widget> categories(BuildContext context) {
  List<Widget> widgets = List<Widget>();
  for (int i = 0; i < allData.length; i++) {
    if (!GameManager.categoryControl.contains(i) &&
        GameManager.validCategories.contains(i))
      widgets.add(categoryCard(GameManager.categoryName(i), context, i));
  }
  return widgets;
}

Widget categoryCard(String category, BuildContext context, int categoryCode) {
  return FlatButton(
    onPressed: () {
      Navigator.of(context)
          .pushNamed('/customizeCategory', arguments: categoryCode);
    },
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.transparent.withOpacity(0),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white12.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                category,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    wordSpacing: 10),
              ),
              SvgPicture.asset(
                GameManager.categoryIcon(categoryCode),
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 20,
                child: Center(
                  child: Text(
                    'Tap to Customize Assignments',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              /*  IconButton(
                icon: Image.asset("images/editIcon.png"),
                iconSize: 30,
                onPressed: () {},
              ), */
            ],
          ),
        ),
      ),
    ),
  );
}
