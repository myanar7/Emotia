import 'dart:math';
import 'package:flutter_svg/svg.dart';

import 'Assignment.dart';

class ScreenArguments {
  final String data;
  final String guess;

  ScreenArguments(this.data, this.guess);
}

class Player {
  final String playerName;
  final int avatarNo;
  int playerPoint = 0;
  bool answer = false;

  Player(this.playerName, this.avatarNo);

  void answerCorrect() {
    answer = true;
  }

  void answerRefresh() {
    answer = false;
  }

  void increasePoint(int point) {
    playerPoint += point;
  }
}

class GameManager {
  /// Tüm Oyuncular
  static List<Player> players = List<Player>();

  /// O anki çizen kişi
  static Player marker;

  ///O anki tahmin edenler listesi
  static List<Player> guessers = List<Player>();

  /// Anlık round bilgisi
  static int round = 0; //MAX SAYISI ROUNDNUM-1 OLACAK
  /// Anlık round içi oyun sırası bilgisi
  static int gameTurn = 0; // guessers * 3 + 0 MARKER
  ///Anlık verilen assignment bilgisi
  static Assignment assignment;

  ///Eğer özelliştirme yapıldıysa o özelleştirmenin listesi
  static List<Assignment> customized =
      List<Assignment>(); //Bu assignment customize olduğulunda kullanılsın
  ///Daha önce gösterilenler listesi
  static List<Assignment> alreadySeen =
      List<Assignment>(); //Bu assignment customize olduğulunda kullanılsın
  ///Özelleştirme yapılan kategorilerin listesi
  static List<int> categoryControl = List<int>();

  ///Kategori ekranında açılmış olan kategorilerin bilgisini tutan liste
  static List<int> validCategories = List<int>();

  //UNUTMA HERHANGİ BİR KATEGORİDEN 12 ADET SEÇİLME OLDUĞU ZAMAN KULLANILSIN...

  GameManager(); // Bir Ebe Playeri Ve Diğerleri Listesi oluştur !
  static void addPlayer(Player newPlayer) {
    players.add(newPlayer);
  }

  static void removePlayer(Player oldPlayer) {
    players.remove(oldPlayer);
  }

  static void removeAll() {
    players.clear();
  }

  static void roundUp() {
    Player temp = marker;
    marker = guessers[round % guessers.length];
    guessers.removeAt(round % guessers.length);
    guessers.insert(round % (guessers.length + 1), temp);
    round++;
    gameTurn = 0;
    for (Player i in guessers) i.answerRefresh();
  }

  static void gameTurnUp() {
    gameTurn++;
  }

  static void setJobs() {
    marker = players[round % players.length];
    List<Player> temp = List<Player>();
    temp.addAll(players); // duplicate methodunu bul burda players vardı
    temp.remove(marker);
    guessers = temp;
  }

  static void sortPlayers() {
    players.sort((a, b) => b.playerPoint.compareTo(a.playerPoint));
  }

  static void setRandomAssignment() {
    int random = 0;
    while (true) {
      random = Random().nextInt(allData.length);
      if (validCategories.contains(random)) break;
    }
    if (categoryControl.contains(random))
      assignment = firstSeen(customized);
    else
      assignment = firstSeen(allData[random]);
    alreadySeen.add(
        assignment); //BU SORUN YARATIRSA NEDENİ STATİC OLMASI ASSİGNMENTİ KOPYALAT VE KOY
  }

  static bool checkAnswer(String answer) {
    /// Space Kontrolü
    List<String> guessWords = answer.split(RegExp(r"\s+"));
    String tempGuess = "";
    for (int j = 0; j < guessWords.length; j++) {
      tempGuess += guessWords.elementAt(j);
    }
    print(
        "++++++++++++++++++++++++++++++++++${guessWords}++++++++++++++++++++++++++++++++++");
    print(
        "++++++++++++++++++++++++++++++++++${assignment.keyWords}++++++++++++++++++++++++++++++++++");

    print(assignment.keyWords.contains(tempGuess));
    return assignment.keyWords.contains(tempGuess);
  }

  static void refresh() {
    players.clear();
    marker = null;
    guessers.clear();
    round = 0;
    gameTurn = 0;
    assignment = null;
    customized.clear();
    categoryControl.clear();
    validCategories.clear();
    alreadySeen.clear();
  }

  static String categoryName(int i) {
    switch (i) {
      case 0:
        return "Movie";
      case 1:
        return "Series";
      case 2:
        return "Video Game";
      case 3:
        return "Book";
      default:
        return "SORUN VAR";

      ///SWİTCH
    }
  }

  static String categoryIcon(int i) {
    switch (i) {
      case 0:
        return 'Assets/Icons/klaket.svg';
      case 1:
        return 'Assets/Icons/tv.svg';
      case 2:
        return 'Assets/Icons/videoGame.svg';
      case 3:
        return 'Assets/Icons/book.svg';
      default:
        return 'CATEGORY ICONA BAK';

      ///SWİTCH
    }
  }

  static Assignment firstSeen(List<Assignment> assignments) {
    Assignment assignment;
    while (true) {
      assignment = assignments.elementAt(Random()
          .nextInt(assignments.length)); //ALREADYSEEN BOŞKEN  SONSUZ DÖNGÜ
      bool controller = false;
      for (Assignment a in alreadySeen) {
        if (a.name == assignment.name) {
          controller = true;
          break;
        }
      }
      if (!controller) break;
    }
    return assignment;
  }
}
