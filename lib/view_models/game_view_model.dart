import 'package:brain_master/widgets/toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';


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

  void init(){

    controller = TextEditingController();
  }


  checkAnswer(context){

    if(answers.contains(404)){
      ScaffoldMessenger.of(context).showSnackBar(Toaster.snackbar());
    }else {
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
    }
  }
}