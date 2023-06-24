import 'package:disney_challenge/constants/strings.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button_facade.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatefulWidget {
  final ContinueButtonFacade manager;

  const ContinueButton({super.key, required this.manager,});

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: TextButton(
        onPressed: widget.manager.onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
              )
          ),
          backgroundColor: widget.manager.backgroundColor,
        ),
        child: const Text(
          continueText,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
