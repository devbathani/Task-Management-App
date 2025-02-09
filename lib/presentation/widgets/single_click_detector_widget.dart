// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class SingleClickDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const SingleClickDetector({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<SingleClickDetector> createState() => _SingleClickDetectorState();
}

class _SingleClickDetectorState extends State<SingleClickDetector> {
  late Timer timer;
  var isClicked = false;
  final int interval = 1000;

  _startTimer() {
    timer = Timer(Duration(milliseconds: interval), () => isClicked = false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isClicked == false) {
            _startTimer();
            widget.onTap();
            isClicked = true;
          }
        });
      },
      child: widget.child,
    );
  }
}
