import 'package:disney_challenge/constants/colors.dart';
import 'package:flutter/material.dart';

class DisneyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const DisneyAppBar({super.key, required this.title});

  @override
  State<DisneyAppBar> createState() => _DisneyAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _DisneyAppBarState extends State<DisneyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: disneyBlue,
          size: 22,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      shape: const Border(
          bottom: BorderSide(
        color: Color(0xffd0d7de),
      )),
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: const TextStyle(
          color: titleTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
