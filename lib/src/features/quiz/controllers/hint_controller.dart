import 'package:flutter/material.dart';

import '../models/puzzle.dart';


class HintController extends ChangeNotifier {
  Puzzle? puzzle;

  void performHint(Puzzle puzzle) {
    this.puzzle = puzzle;
    notifyListeners();
  }
}