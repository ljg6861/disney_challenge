import 'package:flutter/material.dart';

abstract class ContinueButtonFacade{
  final MaterialStateProperty<Color> backgroundColor;

  ContinueButtonFacade(this.backgroundColor);
}