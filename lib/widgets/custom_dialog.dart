import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback onHomeClick;
  final VoidCallback onReplayClick;
  final VoidCallback onNextClick;

  const CustomDialog({
    Key? key,
    required this.onHomeClick,
    required this.onNextClick,
    required this.onReplayClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_rounded, color: Colors.yellow, size: 50,),
                    Icon(Icons.star_rounded, color: Colors.yellow, size: 50,),
                    Icon(Icons.star_rounded, color: Colors.yellow, size: 50,),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: onHomeClick,
                      icon: Icon(Icons.home, color: Colors.indigo, size: 30,),
                    ),
                    SizedBox(width: 40,),
                    IconButton(
                      onPressed: onReplayClick,
                      icon: Icon(Icons.replay, color: Colors.blue, size: 30,),
                    ),
                    SizedBox(width: 40,),
                    IconButton(
                      onPressed: onNextClick,
                      icon: Icon(Icons.skip_next_outlined, color: Colors.green, size: 30,),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 200),
            height: 100,
            padding: EdgeInsets.only(top: 0,left: 10,right: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Image.asset('assets/images/brain.png',width: 70, height: 70,),
          ),
        ],
      ),
    );
  }
}

