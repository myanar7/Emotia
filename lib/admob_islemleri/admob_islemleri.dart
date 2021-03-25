import 'package:firebase_admob/firebase_admob.dart';

class AdmobIslemleri {
  static final String appIDCanli = "ca-app-pub-6673638757024762~1635574786";
  static final String appIdTest = FirebaseAdMob.testAppId;
  static int kacKereGosterildi = 0;
  static final String odulluReklamTest = RewardedVideoAd.testAdUnitId;

  static admobInitialize() {
    FirebaseAdMob.instance.initialize(appId: appIdTest);
  }

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['testApp', 'E-A'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[
      appIdTest,
    ], // Android emulators are considered test devices
  );

//TEST IDLERİ APPİNKİLERLE DEĞİŞTİR
  static InterstitialAd buildInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );


  }
}
