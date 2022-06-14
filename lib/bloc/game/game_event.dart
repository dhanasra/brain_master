part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GetGamePattern extends GameEvent {
  final int side;
  GetGamePattern({required this.side});
}

class GetGameLevel extends GameEvent {
  final bool isNext;
  GetGameLevel({required this.isNext});
}

class AddGameHint extends GameEvent {
  final List values;
  final List hIndex;
  final List pattern;
  AddGameHint({required this.values, required this.hIndex ,required this.pattern});
}