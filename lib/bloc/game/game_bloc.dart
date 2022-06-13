import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:brain_master/view_models/game_view_model.dart';
import 'package:meta/meta.dart';

import '../../matrix.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GetGamePattern>(getPattern);
  }
  
  void getPattern(GetGamePattern event, Emitter<GameState> emit) async{
    emit(GameLoading());

    int side = event.side;
    Matrix matrix =  Matrix(side);
    var pattern = matrix.pattern;

    List values = [];
    List hIndex = [];

    int hint = Random().nextInt(side);
    hint==0 ? hint+=1:'';
    

    for(int i=0;i<pattern.length;i++){

      if(i==side/2){
        var iRow = List.generate(2*side-1, (index){if(index%2!=0){ return ''; }else{ return '='; }});
        values.addAll(iRow);
        GameViewModel.answers.addAll(iRow);
      }else if(i!=0){
        var iRow = List.generate(2*side-1, (index){if(index%2!=0){ return ''; }else{ return '+'; }});
        values.addAll(iRow);
        GameViewModel.answers.addAll(iRow);
      }

      for(int j=0;j<pattern[i].length;j++){

        values.add(pattern[i][j]);

        if(hint==i && hint-1==j){
          hIndex.add(GameViewModel.answers.length);
          GameViewModel.answers.add(pattern[i][j]);
        }else{
          GameViewModel.answers.add(404);
        }

        if((j+1)%side!=0) {
          if((j+1)%(side/2)==0){
            values.add('=');
            GameViewModel.answers.add('=');
          }else{
            values.add('+');
            GameViewModel.answers.add('+');
          }
        }
      }
    }

    values.any((element) { element is String ? GameViewModel.answers.add(element) : ''; return true; });

    emit(GamePattern(values: values, hIndex: hIndex));
  }

}
