import 'dart:math';

import 'package:brain_master/animations/slide_animation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:brain_master/app/app.dart';
import 'package:brain_master/app/app_routes.dart';
import 'package:brain_master/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _showFrontSide;
  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 150),
            child: Image.asset('assets/images/cloud.gif'),
          ),
          body(),
        ],
      )
    );
  }

  Widget body(){

    return Column(
      children: [
        Expanded(
            child: SizedBox(
                width: 250.0,
                child: Align(
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.righteous().fontFamily
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Brain Master',textAlign: TextAlign.center),
                      ],
                      isRepeatingAnimation: false,
                    ),
                  ),
                )
            )
        ),
        Container(
            constraints: BoxConstraints.tight(const Size.square(200.0)),
            child:
            SlideAnimation(
                begin: const Offset(-0.9,0.0),
                end :  const Offset(0.9,0.0),
                duration: 5000,
                child: SlideAnimation(
                    begin: Offset.zero,
                    end : const Offset(0.0,0.1),
                    duration: 500,
                    child: _buildFlipAnimation(),
                    controller: (val){
                      val.repeat(reverse: true);
                    },
                    animation: (val){
                    }
                ),
                controller: (val){
                  val.repeat(reverse: true);
                  val.addStatusListener((status) {
                    if(status == AnimationStatus.reverse){
                      _switchCard(false);
                    }else{
                      _switchCard(true);
                    }
                  });
                },
                animation: (val){
                }
            )
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20,right: 20),
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: (){},
                  child: const Icon(Icons.share)),
              const SizedBox(width: 30,),
              FloatingActionButton(
                  heroTag: 'btn3',
                  onPressed: (){
                    GameViewModel.answers = [];
                    App().setNavigation(context, AppRoutes.gameScreen);
                  },
                  child: const Icon(Icons.play_arrow_sharp)),
              const SizedBox(width: 30,),
              FloatingActionButton(
                  heroTag: 'btn5',
                  onPressed: ()=>App().setNavigation(context, AppRoutes.settingScreen),
                  child: const Icon(Icons.settings))
            ],
          ),
        ),
      ],
    );
  }

  void _switchCard(bool showFrontSide) {
    setState(() {
      _showFrontSide = showFrontSide;
    });
  }

  Widget _buildFlipAnimation() {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFrontSide ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key!);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: Colors.blue,
      faceName: "Front",
      isReverse: true,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Image.asset('assets/images/logo.png', width: 100, height: 100,),
      ),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: const ValueKey(false),
      backgroundColor: Colors.blue.shade700,
      faceName: "Rear",
      isReverse: false,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset('assets/images/logo.png', width: 100, height: 100,),
      ),
    );
  }

  Widget __buildLayout({
    required Key key,
    required Widget child,
    required String faceName,
    required Color backgroundColor,
    required bool isReverse
  }) {

    return Container(
          key: key,
          child: Center(
              child: Transform(
                  alignment: Alignment.center,
                  transform: isReverse ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
                  child: child
              )
          ),
        );
  }
}
