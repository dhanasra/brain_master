import 'dart:math';

import 'package:flutter/material.dart';

class Toaster {

  static snackbar(){

    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Row(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi) ,
            child:Image.asset('assets/images/logo.png', width: 40, height: 40,),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: const Text(
                'Fill all box',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );

  }

}