import 'package:disney_challenge/constants/colors.dart';
import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatefulWidget {
  final Guest guest;
  final Function(Guest) onGuestSelected;

  const UserListTile({super.key, required this.guest, required this.onGuestSelected});

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  late Guest currentGuest;

  @override
  void initState() {
    currentGuest = widget.guest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        children: [
          SizedBox(
              height: 20,
              width: 20,
              child: AbsorbPointer(
                child: Checkbox(
                  value: currentGuest.isSelected,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(width: 1.0, color: checkBoxOutlineColor),
                  ),
                  fillColor: MaterialStateProperty.all(disneyGreen),
                  onChanged: (_) {},
                ),
              )),
          const SizedBox(
            width: 10,
          ),
          Text(
            currentGuest.name,
            style: const TextStyle(color: bodyTextColor, fontSize: 16, fontWeight: FontWeight.w400),
          )
        ],
      ),
      onPressed: () {
        setState(() {
          currentGuest.isSelected = !currentGuest.isSelected;
        });

        widget.onGuestSelected(currentGuest);
      },
    );
  }
}
