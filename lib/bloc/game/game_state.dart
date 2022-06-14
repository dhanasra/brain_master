part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GamePattern extends GameState {
  final List values;
  final List hIndex;
  final List pattern;
  GamePattern({required this.values, required this.hIndex, required this.pattern});
}

class GameWithHint extends GameState {
  final List hIndex;
  GameWithHint({required this.hIndex});
}

class GameLevel extends GameState {
  final String level;

  GameLevel({required this.level});
}