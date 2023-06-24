import 'package:flutter/material.dart';

abstract class ContinueButtonFacade{
  final Function()? onPressed;
  final MaterialStateProperty<Color> backgroundColor;

  ContinueButtonFacade(this.onPressed, this.backgroundColor);
}