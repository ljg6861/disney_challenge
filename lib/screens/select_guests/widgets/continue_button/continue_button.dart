import 'package:disney_challenge/constants/strings.dart';
import 'package:disney_challenge/screens/conflict/conflict_screen.dart';
import 'package:disney_challenge/screens/select_guests/widgets/conflict_bottom_sheet.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button_facade.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/enabled_continue_button_manager.dart';
import 'package:flutter/material.dart';

import '../../../confirmation/confirmation_screen.dart';

class ContinueButton extends StatefulWidget {
  final ContinueButtonFacade manager;

  const ContinueButton({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  _ContinueButtonState createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  void handlePress(BuildContext context) {
    var manager = widget.manager as EnabledContinueButtonManager;

    bool guestsWithReservationSelected = manager.guestData.guestsWithReservation
        .where((element) => element.isSelected)
        .isNotEmpty;
    bool guestsWithoutReservationSelected = manager
        .guestData.guestsWithoutReservation
        .where((element) => element.isSelected)
        .isNotEmpty;

    if (guestsWithReservationSelected && !guestsWithoutReservationSelected) {
      _navigateToConfirmation(context);
      return;
    }

    if (guestsWithReservationSelected && guestsWithoutReservationSelected) {
      _navigateToConflict(context);
      return;
    }

    _showModalBottomSheet(context);
  }

  void _navigateToConfirmation(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ConfirmationScreen()));
  }

  void _navigateToConflict(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ConflictScreen()));
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => const ConflictBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: TextButton(
        onPressed:
            widget.manager.canContinue ? () => handlePress(context) : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          )),
          backgroundColor: widget.manager.backgroundColor,
        ),
        child: const Text(
          continueText,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
