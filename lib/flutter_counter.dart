library counter;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'pages/washing.dart';

typedef void CounterChangeCallback(num value);

class Counter extends StatelessWidget {
  final CounterChangeCallback onChanged;
  Counter({
    Key? key,
    required num initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    required this.decimalPlaces,
    required this.color,
    required this.textStyle,
    this.step = 1,
    this.buttonSize = 25,
  })  : selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;
  final double buttonSize;
  void _incrementCounter() {
    if (selectedValue + step <= maxValue) {
      onChanged((selectedValue + step));
    }
  }

  void _decrementCounter() {
    if (selectedValue - step >= minValue) {
      onChanged((selectedValue - step));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    color = color;
    textStyle = textStyle;
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: _decrementCounter,
              elevation: 2,
              tooltip: 'Decrement',
              backgroundColor: color,
              child: const Icon(
                Icons.remove,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                '${num.parse((selectedValue).toStringAsFixed(decimalPlaces))}',
                style: textStyle),
          ),
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: _incrementCounter,
              elevation: 2,
              tooltip: 'Increment',
              backgroundColor: color,
              child: const Icon(
                Icons.add,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
