
import 'package:software_engg_project/src/features/quiz/models/puzzle.dart';

class NodePath {
  final int goalToDestinationCost;
  final int holderToDestinationCost;
  final List<Puzzle> respectivePuzzle;

  NodePath(this.goalToDestinationCost, this.holderToDestinationCost, this.respectivePuzzle);

  @override
  String toString() {
    return 'NodePath{goalToDestinationCost: $goalToDestinationCost, holderToDestinationCost: $holderToDestinationCost, respectivePuzzle: $respectivePuzzle}';
  }
}