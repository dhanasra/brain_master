
import 'package:brain_master/app/db.dart';
import 'package:brain_master/bloc/game/game_bloc.dart';
import 'package:brain_master/view_models/game_view_model.dart';
import 'package:brain_master/widgets/board.dart';
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
  int side = 7;
  late GameBloc bloc;
  late GameBloc levelBloc;
  late GameViewModel viewModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    bloc = GameBloc();
    levelBloc = GameBloc();
    bloc.add(GetGamePattern(side: (side+1)~/2));
    levelBloc.add(GetGameLevel(isNext: false));
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
              padding: const EdgeInsets.only(left: 0,right: 20),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: BlocBuilder<GameBloc, GameState>(
                      bloc: levelBloc,
                      builder: (context, state){
                        return Text(
                          'Level ${ state is GameLevel ? state.level : ''}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    padding: const EdgeInsets.only(left: 20,right: 20,),
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25), bottomRight: Radius.circular(25)
                        ),
                        boxShadow: [BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10.0,
                        ),]
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                      heroTag: 'home',
                      onPressed: ()=>Navigator.pop(context),
                      child: const Icon(Icons.home_outlined)),
                  const SizedBox(width: 10,),
                  FloatingActionButton(
                      heroTag: 'bulb',
                      onPressed: (){
                        bloc.add(
                            AddGameHint(
                                values: GameViewModel.values,
                                hIndex: GameViewModel.hIndex,
                                pattern: GameViewModel.pattern)
                        );
                      }, child: const Icon(Icons.lightbulb_outline)),
                  const SizedBox(width: 10,),
                  FloatingActionButton(
                      heroTag: 'check',
                      onPressed:()=>viewModel.checkAnswer(context,bloc,levelBloc), child: const Icon(Icons.check)),
                ],
              ),
            ),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: height<width? height : width-50,
                        height: height<width? height: width,
                        child: Center(
                          child: getGrid1(),
                        ),
                      ),
                    ],
                  ),
            ),
            const SizedBox(height: 40,)
          ],
        )
    );
  }

  getGrid1() {
    return BlocBuilder<GameBloc,GameState>(
        bloc: bloc,
        builder: (context, state){
          if(state is GameLoading){
            return const CircularProgressIndicator();
          }else if(state is GamePattern){

            GameViewModel.values = state.values;

            var eCell = [];

            for(var i=0;i<GameViewModel.answers.length;i++){
              if(GameViewModel.answers[i]=='') {
                eCell.add(i);
              }
            }

            return Board(side: side, values: GameViewModel.answers, hIndex: state.hIndex, eCell: eCell);
          }else if(state is GameWithHint){
            var eCell = [];

            for(var i=0;i<GameViewModel.hintAnswers.length;i++){
              if(GameViewModel.hintAnswers[i]=='') {
                eCell.add(i);
              }
            }

            return Board(side: side, values: GameViewModel.hintAnswers, hIndex: state.hIndex, eCell: eCell);
          }else{
            return const CircularProgressIndicator();
          }
        }
    );
  }
}
