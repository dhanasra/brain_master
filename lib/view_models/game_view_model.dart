import 'dart:async';

import 'package:brain_master/app/app.dart';
import 'package:brain_master/app/app_routes.dart';
import 'package:brain_master/app/db.dart';
import 'package:brain_master/bloc/game/game_bloc.dart';
import 'package:brain_master/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

import '../widgets/toaster.dart';


class GameViewModel {

  static late GameViewModel _instance;
  factory GameViewModel() {
    _instance = GameViewModel._internal();
    return _instance;
  }
  GameViewModel._internal() {
    init();
  }

  late TextEditingController controller;
  static int side = 0;
  static List answers = [];
  static List hintAnswers = [];
  static List values = [];
  static List pattern = [];
  static List hIndex = [];
  static List h2Index = [];
  static int level = 0;

  static StreamController levelController = StreamController();

  void init() async{
    controller = TextEditingController();
    level = await DB.get('level');
  }


  checkAnswer(context,bloc,levelBloc){

    if(!answers.contains(404)){
      ScaffoldMessenger.of(context).showSnackBar(Toaster.snackbar());
    }else {

      if(!check(context)) {
        showDialog(
            context: context, builder: (BuildContext buildContext) {
          return CustomDialog(
            onHomeClick: () => onHomeClick(buildContext),
            onReplayClick: () => onReplayClick(buildContext),
            onNextClick: () => onNextClick(buildContext, bloc,levelBloc),
          );
        });
      }else {
        showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(buildContext).pop(true);
            });
            return const AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Icon(Icons.close, color: Colors.red, size: 100,),
            );
          });
      }
    }
  }

  bool check(context){
    int start = 0;
    int end = side;

    for (int i = 0; i < ((side + 1) / 2); i++) {
      var hExp = answers.getRange(start, end).join();
      var hLS = hExp.substring(0, hExp.indexOf('=')).interpret();
      var hRS = hExp.substring(hExp.indexOf('='), hExp.length).interpret();

      if (hLS != hRS) {
        return false;
      }
      start = side + end;
      end = 2 * side + end;

      int j = 2 * i;
      var vExp = [];
      while (j < side * side) {
        vExp.add(answers[j]);
        j = (j + side);
      }

      var vLS = hExp.substring(0, vExp.indexOf('=')).interpret();
      var vRS = hExp.substring(0, vExp.indexOf('=')).interpret();

      if (vLS != vRS) {
        return false;
      }
    }

    return true;
  }

  onHomeClick(BuildContext context){
    App().setNavigation(context, AppRoutes.homeScreen);
  }

  onReplayClick(BuildContext context){
    Navigator.pop(context);
  }

  onNextClick(BuildContext context,GameBloc bloc, GameBloc levelBloc){
    answers = [];
    hintAnswers = [];
    bloc.add(GetGamePattern(side: (side+1)~/2));
    levelBloc.add(GetGameLevel(isNext: true));
    Navigator.pop(context);
  }
}