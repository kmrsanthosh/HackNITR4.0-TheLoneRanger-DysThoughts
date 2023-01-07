import 'package:flutter/cupertino.dart';

import '../database/hive_database.dart';
import '../models/score_card.dart';



class ScoreCardController extends ChangeNotifier {
  ScoreCard? scoreCard;
  HiveDatabase database = HiveDatabase();

  void getScore(int level) {
    scoreCard = database.getScore(level);
    notifyListeners();
  }

  void getInitialScore(int level) {
    scoreCard = database.getScore(level);
  }

  void saveScore(ScoreCard score, int level) async {
    await database.saveScore(score).then((value) {
      scoreCard = database.getScore(level);
      notifyListeners();
    });
  }

}