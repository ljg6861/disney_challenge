import 'package:disney_challenge/constants/colors.dart';
import 'package:disney_challenge/screens/select_guests/models/guest_data.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button_facade.dart';
import 'package:flutter/material.dart';

class EnabledContinueButtonManager implements ContinueButtonFacade{
  final GuestData guestData;

  EnabledContinueButtonManager({required this.guestData});
  
  @override
  MaterialStateProperty<Color> get backgroundColor => MaterialStateProperty.all(disneyBlue);

  @override
  bool get canContinue => true;
}