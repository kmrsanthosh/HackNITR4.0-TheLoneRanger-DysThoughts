import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';




























import 'package:provider/provider.dart';

import '../algorithms/a_star_algo.dart';
import '../algorithms/active_child_algo.dart';
import '../constants/constants.dart';
import '../controllers/hint_controller.dart';
import '../controllers/order_controller.dart';
import '../controllers/puzzle_controller.dart';
import '../controllers/score_card_controller.dart';
import '../controllers/shuffle_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/time_controller.dart';
import '../enums/shuffle_action.dart';
import '../models/puzzle.dart';
import '../styles/text_style.dart';
import '../widgets/circular_icon_tile.dart';
import '../widgets/column_orientation_builder.dart';
import '../widgets/cupertino_color_selector.dart';
import '../widgets/material_color_selector.dart';
import '../widgets/my_grid_painter.dart';
import '../widgets/my_orientation_builder.dart';
import '../widgets/my_reverse_orientation.dart';
import '../widgets/puzzle_card.dart';
import '../widgets/puzzle_draggable_tile.dart';
import '../widgets/rounded_icon_tile.dart';

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  _PuzzleBoardState createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  // final Random random = Random();

  // Color get gradientColor1 => Color.fromRGBO(
  //       random.nextInt(155) + 100,
  //       random.nextInt(155) + 100,
  //       random.nextInt(155) + 100,
  //       0.5,
  //     );
  // Color get gradientColor2 => Color.fromRGBO(
  //       random.nextInt(155) + 100,
  //       random.nextInt(155) + 100,
  //       random.nextInt(155) + 100,
  //       0.5,
  //     );
  //
  // Color get color => Color.fromRGBO(
  //       Random().nextInt(200),
  //       Random().nextInt(200),
  //       Random().nextInt(200),
  //       1.0,
  //     );
  //
  // Color? tileColor;

  late GlobalKey shuffleKey;

  late BuildContext ctx;

  @override
  void initState() {
    super.initState();
    shuffleKey = GlobalKey();
    //tileColor ??= color;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: MyOrientationBuilder(
        children: [
          ColumnOrientationBuilder(
            children: [
              Wrap(
                runSpacing: 10.00,
                spacing: 50.00,
                children: [
                  Text(
                    "Math Magic",
                    style: ts20ptPacificoMEDIUM.copyWith(
                      fontSize: 25.00,
                      color: theme.textTheme.headline1!.color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<PuzzleController>(builder: (context, controller, child) {
                        return Row(
                          children: [
                            AnimatedScale(
                              scale: controller.level > 1 ? 1.00 : 00,
                              duration: const Duration(milliseconds: 100),
                              alignment: Alignment.center,
                              child: CircularIconTile(
                                icon: Icons.remove,
                                onTap: _onPreviousTap,
                              ),
                            ),
                            const SizedBox(width: 10.00),
                            Text(
                              "level ${controller.level}",
                              style: ts20ptPacificoMEDIUM.copyWith(
                                fontSize: 20.00,
                                color: theme.textTheme.headline1!.color,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      }),
                      const SizedBox(width: 10.00),
                      CircularIconTile(
                        icon: Icons.add,
                        onTap: _onNextTap,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30.00),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.00),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const RoundedIconTile(icon: Icons.timer_rounded),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            "Time Elapsed",
                            style: ts20ptPacificoMEDIUM.copyWith(
                              fontSize: 18.00,
                              color: theme.textTheme.headline2!.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Consumer<TimeController>(builder: (context, timerController, child) {
                      return Text(
                        timerController.duration.duration,
                        style: ts20ptPoiretOneBOLD.copyWith(
                          fontSize: 18.00,
                          letterSpacing: 5.00,
                          color: theme.textTheme.subtitle1!.color,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20.00),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.00),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const RoundedIconTile(icon: Icons.grid_3x3),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            "Moves Tried",
                            style: ts20ptPacificoMEDIUM.copyWith(
                              fontSize: 18.00,
                              color: theme.textTheme.headline2!.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Consumer<PuzzleController>(builder: (context, controller, child) {
                      return Text(
                        "${controller.moves}",
                        style: ts20ptPoiretOneBOLD.copyWith(
                          fontSize: 18.00,
                          letterSpacing: 5.00,
                          color: theme.textTheme.subtitle1!.color,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20.00),
              Consumer<ScoreCardController>(builder: (context, controller, child) {
                return Visibility(
                  visible: controller.scoreCard != null,
                  child: AnimatedScale(
                    scale: controller.scoreCard != null ? 1.00 : 00,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.00),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const RoundedIconTile(icon: Icons.wine_bar),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  "Best Score",
                                  style: ts20ptPacificoMEDIUM.copyWith(
                                    fontSize: 18.00,
                                    color: theme.textTheme.headline2!.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Consumer<TimeController>(builder: (context, timerController, child) {
                            return Text(
                              "${controller.scoreCard?.duration.toString()} in ${controller.scoreCard?.moves.toString()}",
                              style: ts20ptPoiretOneBOLD.copyWith(
                                fontSize: 18.00,
                                color: theme.textTheme.subtitle1!.color,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 5.00),
          SizedBox(
            // width: max(size.width, size.height) * 0.40,
            // height: max(size.width, size.height) * 0.40,
            width: (size.height + size.width) * 0.27,
            height: (size.height + size.width) * 0.27,
            child: Consumer<PuzzleController>(builder: (context, puzzleController, child) {
              var puzzleCards = puzzleController.puzzles;
              var destinationChildIndex = puzzleCards.indexWhere((element) => element.cardValue == puzzleController.endingCardValue);
              var activeCards = ActiveChildAlgo.activeCardsFor9(puzzleCards, destinationChildIndex);
              return Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(8.00),
                ),
                child: CustomPaint(
                  painter: MyGridPainter(theme.backgroundColor.withOpacity(0.7)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.00),
                    ),
                    padding: const EdgeInsets.all(10.00),
                    height: (min(size.height, size.width) * 0.25) * 3.5,
                    width: (min(size.height, size.width) * 0.25) * 3.5,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      reverseDuration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      child: puzzleController.isGameCompleted
                          ? InkWell(
                        onTap: _onNextTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.backgroundColor,
                          ),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text("Congratulations!",
                                    style: ts20ptPacificoREGULAR.copyWith(fontSize: 25.00, color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text("You have Completed the Level ${puzzleController.level}",
                                    style: ts20ptPacificoREGULAR.copyWith(color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text("Next Things In Development", style: ts20ptPacificoREGULAR.copyWith(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      )
                          : Stack(
                        alignment: Alignment.center,
                        fit: StackFit.passthrough,
                        children: List.generate(puzzleCards.length, (index) {
                          bool isActiveChild = activeCards.any((element) => element.cardValue == puzzleCards[index].cardValue);
                          return PuzzleDraggableTile(
                            currentChild: puzzleCards[index],
                            isActiveChild: isActiveChild,
                            currentChildAlignment: d3Aligns[index],
                            destinationChildAlignment: d3Aligns[destinationChildIndex],
                            index: index,
                            endingCardValue: puzzleController.endingCardValue,
                            child: PuzzleCard(
                              puzzle: puzzleCards[index],
                              endCardValue: puzzleController.endingCardValue,
                              color: theme.backgroundColor,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          //const SizedBox(height: 5.00),
          SafeArea(
            child: MyReverseOrientation(
              children: [
                RoundedIconTile(
                  icon: Icons.shuffle,
                  onTap: _onResetTap,
                ),
                RoundedIconTile(
                  icon: Icons.lightbulb_outline,
                  onTap: _onHintTap,
                ),
                RoundedIconTile(
                  icon: Icons.check,
                  onPanDown: _onCheckDown,
                  onPanEnd: _onCheckEnd,
                ),
                Consumer<ThemeController>(builder: (context, themeC, child) {
                  return RoundedIconTile(
                    icon: Icons.color_lens,
                    onTap: () => _onThemeChange(),
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onResetTap() {
    Provider.of<ShuffleController>(context, listen: false).doAnimate(ShuffleAction.noChange);
  }

  void _onNextTap() {
    //Provider.of<PuzzleController>(context, listen: false).increaseLevel();
    Provider.of<ShuffleController>(context, listen: false).doAnimate(ShuffleAction.increase);
  }

  void _onThemeChange() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return const CupertinoColorSelector();
        } else {
          return const MaterialColorSelector();
        }
      },
    );
    Provider.of<ThemeController>(context, listen: false).changeTheme(result);
  }

  void _onHintTap() {
    var pro = Provider.of<PuzzleController>(context, listen: false);
    Puzzle? walkablePuzzle = AStarAlgo.getWalkablePuzzle(pro.puzzles, pro.endingCardValue);

    if (walkablePuzzle != null) {
      Provider.of<HintController>(context, listen: false).performHint(walkablePuzzle);
    }
  }

  void _onCheckDown(DragDownDetails details) {
    Provider.of<OrderController>(context, listen: false).showOrder(true);
  }

  void _onCheckEnd(DragEndDetails details) {
    Provider.of<OrderController>(context, listen: false).showOrder(false);
  }

  void _onPreviousTap() {
    //Provider.of<PuzzleController>(context, listen: false).decreaseLevel();
    Provider.of<ShuffleController>(context, listen: false).doAnimate(ShuffleAction.decrease);
  }
}
