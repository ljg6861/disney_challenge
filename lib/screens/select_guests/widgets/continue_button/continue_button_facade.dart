import 'package:flutter/material.dart';

abstract class ContinueButtonFacade{
  final MaterialStateProperty<Color> backgroundColor;
  final bool canContinue;

  ContinueButtonFacade(this.backgroundColor, this.canContinue);
}