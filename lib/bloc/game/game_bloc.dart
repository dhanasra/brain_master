import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:brain_master/app/db.dart';
import 'package:brain_master/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../matrix.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GetGamePattern>(getPattern);
    on<AddGameHint>(addHint);
    on<GetGameLevel>(getGameLevel);
  }

  void getGameLevel(GetGameLevel event, Emitter<GameState> emit) async{
    emit(GameLoading());
    var level = await DB.get('level');
    level = level!=null ? event.isNext ? level+1 : level : 1;
    event.isNext ? await DB.save('level', level??1) : null;
    emit(GameLevel(level: '$level'));
  }
  
  void getPattern(GetGamePattern event, Emitter<GameState> emit) async{
    emit(GameLoading());

    int side = event.side;
    Matrix matrix =  Matrix(side);
    var pattern = matrix.pattern;

    List values = [];
    List hIndex = [];

    for(int i=0;i<pattern.length;i++){

      if(i==side/2){
        var iRow = List.generate(2*side-1, (index){if(index%2!=0){ return ''; }else{ return '='; }});
        values.addAll(iRow);
        GameViewModel.answers.addAll(iRow);
        GameViewModel.hintAnswers.addAll(iRow);
      }else if(i!=0){
        var iRow = List.generate(2*side-1, (index){if(index%2!=0){ return ''; }else{ return '+'; }});
        values.addAll(iRow);
        GameViewModel.answers.addAll(iRow);
        GameViewModel.hintAnswers.addAll(iRow);
      }

      for(int j=0;j<pattern[i].length;j++){

        values.add(pattern[i][j]);

        if(
        (i==0 && j==0) || (i==0 && j==pattern.length-1)
            || (i==pattern.length-1 && j==0) || (i==pattern.length-1 && j==pattern.length-1) ){
          hIndex.add(GameViewModel.answers.length);
          GameViewModel.answers.add(pattern[i][j]);
          GameViewModel.hintAnswers.add(pattern[i][j]);
        }else{
          GameViewModel.answers.add(404);

          if(
          (i==pattern.length/2-1 && j==pattern.length/2-1) || (i==pattern.length/2-1 && j==pattern.length/2)
          || (i==pattern.length/2 && j==pattern.length/2-1) || (i==pattern.length/2 && j==pattern.length/2)
          ){
            GameViewModel.hintAnswers.add(pattern[i][j]);
          }else{
            GameViewModel.hintAnswers.add(404);
          }

        }


        if((j+1)%side!=0) {
          if((j+1)%(side/2)==0){
            values.add('=');
            GameViewModel.answers.add('=');
            GameViewModel.hintAnswers.add('=');
          }else{
            values.add('+');
            GameViewModel.answers.add('+');
            GameViewModel.hintAnswers.add('+');
          }
        }
      }
    }

    GameViewModel.hIndex = hIndex;

    values.any((element) { element is String ? GameViewModel.answers.add(element) : ''; return true; });

    emit(GamePattern(values: values, hIndex: hIndex, pattern: pattern));
  }

  void addHint(AddGameHint event, Emitter<GameState> emit) async{
    emit(GameLoading());

    var hIndex = event.hIndex;

    for(int i=0;i<GameViewModel.hintAnswers.length;i++){
      if(GameViewModel.hintAnswers[i]!=404 && int.tryParse('${GameViewModel.hintAnswers[i]}')!=null){
        hIndex.add(i);
      }
    }

    emit(GameWithHint(hIndex: hIndex));
  }

}
