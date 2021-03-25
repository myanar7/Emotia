import 'package:ea/Assignment.dart';
import 'package:ea/playScreen.dart';
import 'package:ea/screenArguments.dart';
import 'package:ea/widgets.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xlive_switch/xlive_switch.dart';
import 'admob_islemleri/admob_islemleri.dart';
import 'colors.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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


  List<bool> categories = List(8);
  List<int> categoryCodes = List<int>();

  @override
  void initState() {
    categoryCodes.add(0);
    for (int i = 0; i < 8; i++) {
      if (i == 0)
        categories[i] = true;
      else
        categories[i] = false;
    }
    // TODO: implement initState

/*    RewardedVideoAd.instance.load(
        adUnitId: AdmobIslemleri.odulluReklamTest,
        targetingInfo: AdmobIslemleri.targetingInfo);
*/
    super.initState();
  }

  void odulluReklamLoad() {
    RewardedVideoAd.instance.load(
        adUnitId: AdmobIslemleri.odulluReklamTest,
        targetingInfo: AdmobIslemleri.targetingInfo);
  }

//REKLAM İLE ALAKALI OLAN PENCERE
  void alertDialogReklam(BuildContext context, int categoryNum, bool value) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(12),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
            title: Text(
              "Warning",
              style: TextStyle(color: Colors.white),
            ),
            content: Text("View ad to open the category!",
                style: TextStyle(color: Colors.white)),
            actions: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FlatButton.icon(
                      onPressed: () {
                        return {
                          RewardedVideoAd.instance.load(
                              adUnitId: AdmobIslemleri.odulluReklamTest,
                              targetingInfo: AdmobIslemleri.targetingInfo),
                          RewardedVideoAd.instance.listener =
                              (RewardedVideoAdEvent event,
                                  {String rewardType, int rewardAmount}) {
                            if (event == RewardedVideoAdEvent.rewarded) {
                              print(
                                  "--------------REKLAM İZLENMEYE BAŞLADI-----------------");
                              //  odulluReklamLoad();
                            } else if (event == RewardedVideoAdEvent.loaded) {
                              print(
                                  "----------REKLAMI YÜKLENDİ VE GÖSTERİME GİRECEK------------------");
                              RewardedVideoAd.instance.show();
                            } else if (event == RewardedVideoAdEvent.closed) {
                              print(
                                  "------------------REKLAMI KAPATTI----------------------");
                            } else if (event ==
                                RewardedVideoAdEvent.failedToLoad) {
                              odulluReklamLoad();
                              print(
                                  "---------------REKLAM BULUNAMADI/YÜKLENEMEDİ-------------");
                            } else if (event ==
                                RewardedVideoAdEvent.completed) {
                              print(
                                  "--------------------REKLAMI İZLEDİ ACCES VER-----------------");
                              setState(() {
                                categoryCodes.add(categoryNum);
                                categories[categoryNum] = value;
                                print(categoryNum);
                              });
                              categories[categoryNum] =
                                  value; //   AdmobIslemleri.kacKereGosterildi++;
                              Navigator.of(context).pop(true);
                            }
                          }
                        };
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      label:
                          Text("Yes", style: TextStyle(color: Colors.white))),
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
                ],
              )
            ],
          );
        });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(212, 178, 135, 1),
        title: Text(
          "CATEGORIES",
          style: TextStyle(
            color: Colors.white, wordSpacing: 1, fontSize: 30,
            //  fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: _backPress,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: ColorsAll.gradient),
          child: GridView(
            padding: EdgeInsets.only(top: 15),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: categoryList(),
          ),
        ),
      ),
    );
  }

  List<Widget> categoryList() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < allData.length; i++) {
      list.add(Padding(
          padding: EdgeInsets.only(top: 15, right: 7.5, left: 7.5),
          child: GameCategory(context, i, categories)));
    }
    list.add(SizedBox(
      height: 150,
      child: Center(
        child: Widgets.greenButton(50, Icons.play_arrow, () {
          for (int i = 0; i < categories.length; i++)
            if (categories[i] == true) GameManager.validCategories.add(i);
          Navigator.of(context).pushReplacementNamed('/createCategory');
        }),
      ),
    ));
    return list;
  }

  Widget GameCategory(
      BuildContext context, int categoryNum, List<bool> categories) {
    //Kategoriler İçin not: kullanırken List<bool> yapın her switch için ve bir int parametresi kullan
    double widthOfScreen = MediaQuery.of(context).size.width;
    return Container(
        width: widthOfScreen * 4 / 10,
        height: widthOfScreen * 5 / 10,
        decoration: BoxDecoration(
            border: Border.all(
          width: 8,
          color: Colors.transparent,
        )),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                GameManager.categoryName(categoryNum),
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SvgPicture.asset(
                GameManager.categoryIcon(categoryNum),
                width: widthOfScreen * 8 / 25,
              ),
              XlivSwitch(
                activeColor: Colors.lightGreen,
                unActiveColor: Colors.black12,
                thumbColor: Colors.white.withOpacity(1),
                value: categories[categoryNum],
                onChanged: (bool value) {
                  setState(() {
                    //=>alertDialogReklam tetiklenince pencere açılıyor bu pencerenin yukarıdaki onPressine yazdığımız şey burada
                    //=> reklam izlemek istiyor musunuz sorusuna evete bastığımız anda hem switchi true yapmalı hem de reklamı döndürmeli

                    if (!categoryCodes.contains(categoryNum)) {
                      if (value == true) {
                        alertDialogReklam(context, categoryNum, value);
                      }
                    } else {
                      setState(() {
                        categories[categoryNum] = value;
                      });
                    }

                    /* myInterstitialAd = AdmobIslemleri.buildInterstitialAd();
                    if (AdmobIslemleri.kacKereGosterildi <= 4) {
                      myInterstitialAd
                        ..load()
                        ..show();
                      AdmobIslemleri.kacKereGosterildi++;
                    }*/
                  });
                },
              ),
            ],
          ),
        ));
  }
}
