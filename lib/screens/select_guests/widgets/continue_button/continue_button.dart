import 'package:disney_challenge/constants/strings.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button_facade.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/disabled_continue_button_manager.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/enabled_continue_button_manager.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatefulWidget {
  final ContinueButtonFacade manager;

  const ContinueButton({
    super.key,
    required this.manager,
  });

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
        onPressed: (widget.manager is DisabledContinueButtonManager)
            ? null
            : () {
                var manager = widget.manager as EnabledContinueButtonManager;

                if (manager.guestData.guestsWithReservation.where((element) => element.isSelected).isEmpty) {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: const Color(0xff00233c),
                          padding: EdgeInsets.only(left: 16, bottom: MediaQuery.of(context).padding.bottom, right: 16),
                          height: 92 + MediaQuery.of(context).padding.bottom,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reservation Needed',
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                                    ),
                                    Flexible(
                                        child: Text(
                                      'Select at least one Guest that has a reservation to continue.',
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Color(0xff00233c),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
              },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          )),
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
