import 'package:brain_master/bloc/game/game_bloc.dart';
import 'package:brain_master/view_models/game_view_model.dart';
import 'package:brain_master/widgets/board.dart';
import 'package:brain_master/widgets/cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  late double width;
  late double height;
  int _value = 0;
  int side = 7;
  late GameBloc bloc;
  late GameViewModel viewModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    bloc = GameBloc();
    bloc.add(GetGamePattern(side: (side+1)~/2));
    viewModel = GameViewModel();
    GameViewModel.side = 7;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20,right: 20),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                      heroTag: 'home',
                      onPressed: (){}, child: Icon(Icons.home_outlined)),
                  SizedBox(width: 10,),
                  FloatingActionButton(
                      heroTag: 'bulb',
                      onPressed: (){}, child: Icon(Icons.lightbulb_outline)),
                  SizedBox(width: 10,),
                  FloatingActionButton(
                      heroTag: 'check',
                      onPressed:()=>viewModel.checkAnswer(context), child: Icon(Icons.check)),
                ],
              ),
            ),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: height<width? height-150 : width- 150,
                        height: height<width? height-150 : width- 150,
                        child: Center(
                          child: getGrid1(),
                        ),
                      ),
                    ],
                  ),
            ),
            SizedBox(height: 40,)
          ],
        )
    );
  }



  showWrongDialog(con){
    var isCorrect = viewModel.checkAnswer(con);
    showDialog(
        context: _scaffoldKey.currentContext!,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: isCorrect ?
            Icon(Icons.check, color: Colors.green,size: 100,)
            : Icon(Icons.close, color: Colors.red,size: 100,),
          );
        });
  }


  getGrid1() {
    return BlocBuilder<GameBloc,GameState>(
        bloc: bloc,
        builder: (context, state){
          if(state is GameLoading){
            return CircularProgressIndicator();
          }else if(state is GamePattern){

            var eCell = [];


            for(var i=0;i<GameViewModel.answers.length;i++){
              if(GameViewModel.answers[i]=='') {
                eCell.add(i);
              }
            }

            print(eCell);

            return Board(side: side, values: GameViewModel.answers, hIndex: state.hIndex, eCell: eCell);
          }else{
            return Text('Sorry');
          }
        }
    );
  }
}
