import 'package:disney_challenge/constants/colors.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button_facade.dart';
import 'package:flutter/material.dart';

class DisabledContinueButtonManager implements ContinueButtonFacade{
  @override
  MaterialStateProperty<Color> get backgroundColor => MaterialStateProperty.all(disneyDisabledBlue);

  @override
  bool get canContinue => false;
}