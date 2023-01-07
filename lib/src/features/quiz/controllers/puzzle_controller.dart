import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:software_engg_project/src/features/quiz/controllers/score_card_controller.dart';
import 'package:software_engg_project/src/features/quiz/controllers/time_controller.dart';







import 'dart:developer' as developer;

import '../algorithms/equality_algo.dart';
import '../constants/constants.dart';
import '../database/hive_database.dart';
import '../models/puzzle.dart';
import '../models/score_card.dart';



class PuzzleController extends ChangeNotifier {
  static final Random random = Random();
  List<Puzzle> puzzles = [];
  late int endingCardValue;

  final TimeController timeController;
  final ScoreCardController scoreController;

  PuzzleController(this.timeController, this.scoreController);

  int moves = 0;
  int level = 1;
  int gridNumber = 3;
  bool isGameCompleted = false;

  void initInitialCard() {
    HiveDatabase().clearParentPuzzle();
    HiveDatabase().saveBoardValue(Board.goalNode, null);
    final lastLevel = HiveDatabase().getBoardValue(Board.currentLevel);
    if(lastLevel != null) {
      level = lastLevel;
    }
    List<int> values = getValues(level, gridNumber * gridNumber);
    values.shuffle(random);

    for (int i = 0; i < (gridNumber * gridNumber); i++) {
      puzzles.add(Puzzle(values[i]));
    }
    notifyListeners();
    timeController.initValues();
    scoreController.getInitialScore(level);
  }



  void initCards({int? grid}) {
    puzzles.clear();
    moves = 0;

    if(grid != null) {
      gridNumber = grid;
    }

    int totalNumbers = gridNumber * gridNumber;

    List<int> values = getValues(level, totalNumbers);
    values.shuffle(random);

    for (int i = 0; i < totalNumbers; i++) {
      puzzles.add(Puzzle(values[i]));
    }
    isGameCompleted = false;
    notifyListeners();
    timeController.initValues();
    scoreController.getInitialScore(level);
    HiveDatabase().clearParentPuzzle();
    HiveDatabase().saveBoardValue(Board.goalNode, null);
  }

  void swapChildren(Puzzle puzzle) {
    final holderIndex = puzzles.indexWhere((element) => element.cardValue == endingCardValue);
    final childIndex = puzzles.indexWhere((element) => element.cardValue == puzzle.cardValue);

    puzzles[childIndex] = Puzzle(endingCardValue);
    puzzles[holderIndex] = Puzzle(puzzle.cardValue);

    notifyListeners();
    startTimerWithMoves();
    checkForEnd();
  }

  List<int> getValues(int level, int total) {
    List<int> numbers = [];

    int ending = total * level;
    endingCardValue = ending;

    for (int i = 0; i < total; i++) {
      numbers.add(ending - i);
    }
    return numbers;
  }

  void startTimerWithMoves() {
    moves++;
    notifyListeners();
    timeController.startTimer();
  }

  void checkForEnd() {
    List<int> currentList = puzzles.map((e) => e.cardValue).toList();
    List<int> sortedList = puzzles.map((e) => e.cardValue).toList();
    sortedList.sort();

    bool isEqual = EqualityAlgo.isIntEqual(currentList, sortedList);

    if (!isEqual) {
      developer.log("Match Not Found!");
    } else {
      ScoreCard scoreCard = ScoreCard(level, moves, timeController.duration.duration, DateTime.now().toIso8601String());
      timeController.cancelStopwatch();
      scoreController.saveScore(scoreCard, level);
      isGameCompleted = true;
      notifyListeners();
      developer.log("Match Found! Game Complete");
    }
  }

  void increaseLevel() {
    level++;
    getScore();
    puzzles.clear();
    initCards();
    HiveDatabase().saveBoardValue(Board.currentLevel, level);
  }

  void decreaseLevel() {
    level--;
    getScore();
    puzzles.clear();
    initCards();
  }

  void getScore() {
    scoreController.getScore(level);
  }

  void swapTwoChildren(Puzzle first, Puzzle last) {
    final lastIndex = puzzles.indexWhere((element) => element.cardValue == last.cardValue);
    final childIndex = puzzles.indexWhere((element) => element.cardValue == first.cardValue);

    puzzles[childIndex] = Puzzle(last.cardValue);
    puzzles[lastIndex] = Puzzle(first.cardValue);

    notifyListeners();
  }
}
