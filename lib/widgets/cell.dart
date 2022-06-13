import 'package:brain_master/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/services.dart';


class Cell extends StatefulWidget {
  final value;
  final bool isActive;
  final bool isPlaceholder;
  final bool isEmpty;
  final VoidCallback onClick;
  final ValueChanged onTextChange;

  const Cell({
    Key? key,
    required this.value,
    required this.onClick,
    required this.isActive,
    required this.onTextChange,
    required this.isPlaceholder,
    required this.isEmpty
  }) : super(key: key);

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {

  late GameViewModel viewModel;

  @override
  void initState() {
    viewModel = GameViewModel();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: !widget.isEmpty ?
        widget.value=='' || (widget.value is int) || int.tryParse(widget.value)!=null ?
        ClayContainer(
            color: const Color(0xFFF2F2F2),
            height: 200,
            width: 200,
            child: Container(
                color: widget.isPlaceholder ? Colors.pinkAccent : widget.isActive ? Colors.yellowAccent : Colors.greenAccent,
                child: Center(
                  child:
                  TextField(
                    onTap: widget.onClick,
                    controller: viewModel.controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      hintText: widget.isPlaceholder ? '${widget.value}' : '',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    showCursor: false,
                    maxLength: 2,
                    readOnly: widget.isPlaceholder,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),
                    onChanged: widget.onTextChange,
                  )
                )
                )
        )
        : Container(
          color: Colors.transparent,
          child: Center(
            child: Text(
              '${widget.value}',
              style: TextStyle(
                  color: widget.value=='+' ? Colors.red : Colors.indigo,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        )
      : const SizedBox()
    );
  }
}
