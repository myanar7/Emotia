import 'package:ea/playScreen.dart';
import 'package:ea/playerAdd.dart';
import 'package:ea/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IS extends StatefulWidget {
  @override
  _ISState createState() => _ISState();
}

class _ISState extends State<IS> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PlayerAdd()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        'Assets/Images/Introduction/$assetName.png',
        width: 400.0,
        fit: BoxFit.cover,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
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

    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white70);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontFamily: "Raleway"),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(1, 1, 1, 1),
      pageColor: Color.fromRGBO(212, 178, 135, 1),
      imagePadding: EdgeInsets.all(12),
      titlePadding: EdgeInsets.all(12),
      contentPadding: EdgeInsets.all(60),
      imageFlex: 8,
      bodyFlex: 5,
      footerPadding: EdgeInsets.all(12),
    );

    return WillPopScope(
      onWillPop: _backPress,
      child: IntroductionScreen(
        showNextButton: false,
        curve: Curves.easeInExpo,
        onSkip: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => PS(),
            ),
          );
        },
        globalBackgroundColor: Color.fromRGBO(212, 178, 135, 1),
        key: introKey,
        pages: [
          PageViewModel(
            title: "CHOOSE YOUR CATEGORY",
            image: _buildImage('choose'),
            body: "Movies/Series/Games/Books",
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "WHAT YOU WATCH/READ/PLAY",
//            title: "CUSTOMIZE ACCORDING TO WHAT YOU WATCH/READ/PLAY",
            body: "Customize according to what you watch read or play",
            image: _buildImage('according'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "GIVE THE PHONE TO MARKER",
            body: "The person to tell the assignment by using emojies",
            image: _buildImage('marker'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "GUESSERS",
            body: "People who will enter their estimates",
            image: _buildImage('guesser'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "YOU HAVE 3 CHANCES TO EARN POINTS",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "First estimate : 10",
                  style: TextStyle(fontSize: 19.0, color: Colors.white70),
                ),
                Text(
                  "Second estimate : 8",
                  style: TextStyle(fontSize: 19.0, color: Colors.white70),
                ),
                Text(
                  "Third estimate : 6",
                  style: TextStyle(fontSize: 19.0, color: Colors.white70),
                ),
              ],
            ),
            image: _buildImage('three'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "BE AT THE TOP OF THE LEADERBOARD",
            body:
                "Those who do it right at the right time are often at the top in emotia",
            image: _buildImage('leaderboard'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(milliseconds: 500),
                    child: Text("Press", style: bodyStyle)),
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(milliseconds: 500),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            image: _buildImage('logo'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text(
          'Skip',
          style: TextStyle(color: Colors.white),
        ),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        done: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Widgets.greenButton(
              50,
              Icons.play_arrow,
              () {
                Navigator.push(
                    context, CupertinoPageRoute(builder: (context) => PS()));
              },
            )
          ],
        ),
        dotsDecorator: const DotsDecorator(
          size: Size(8.0, 8.0),
          color: Color.fromRGBO(212, 178, 135, 1),
          activeColor: Colors.lightGreen,
          activeSize: Size(12.0, 8.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
