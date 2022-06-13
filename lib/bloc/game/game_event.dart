part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GetGamePattern extends GameEvent {
  final int side;
  GetGamePattern({required this.side});
}