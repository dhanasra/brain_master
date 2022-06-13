import 'dart:math';
import 'package:collection/collection.dart';

class Matrix {

  final int side;
  late List<List<int>> pattern;
  int sum =0;

  Matrix(this.side){

    pattern = List.generate(side, (i) => List.filled(side,0), growable: false);

    for(int i=0;i<side;i++){
      sum = 0;
      for(int j=0;j<side;j++){

        if(i<side/2 && j<side/2){

          int a = Random().nextInt(10);
          pattern[i][j] = a;

        }else if(i<side/2 && j<side){

          int tLR = pattern[i].take(side~/2).sum;
          if(j==side-1){
            pattern[i][j] = tLR - sum;
          }else{
            pattern[i][j] =  Random().nextInt(tLR-sum);
            sum += pattern[i][j];
          }

        }else if(i<side && j<side/2){

          int vDiff = gVDiff(j);

          if(i==side-1){
            pattern[i][j] = vDiff;
          }else{
            pattern[i][j] = Random().nextInt(vDiff);
          }

        }else{

          int vSUM = gVSum(0,i,j);
          int hSUM = pattern[i].take(j).sum;

          int min = hSUM<vSUM?hSUM:vSUM;

          if(j==side-1){

            int hLS = pattern[i].take(side~/2).sum;
            int hRS = pattern[i].getRange(side~/2,side-1).sum;

            pattern[i][j] = hLS-hRS;

          }else if(i==side-1){

            int vDiff = gVDiff(j);
            pattern[i][j] = vDiff;

          }else{

            pattern[i][j] = Random().nextInt(min);

          }
        }
      }
    }
  }

  int gVDiff(int j){

    int sides = gVSum(0,side~/2,j);
    int secondSides = gVSum(side~/2,side,j);

    return sides-secondSides;
  }

  int gVSum(int lVar,int limit,int j){
    int vSUM = 0;
    int loopVar = lVar;
    while(loopVar<limit){
      vSUM+=pattern[loopVar][j];
      loopVar++;
    }
    return vSUM;
  }

}
