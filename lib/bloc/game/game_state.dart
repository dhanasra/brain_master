part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GamePattern extends GameState {
  final List values;
  final List hIndex;
  GamePattern({required this.values, required this.hIndex});
}
