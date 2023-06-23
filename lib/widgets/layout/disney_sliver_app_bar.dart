import 'package:disney_challenge/constants/colors.dart';
import 'package:flutter/material.dart';

class DisneySliverAppBar extends StatefulWidget {
  final String title;

  const DisneySliverAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<DisneySliverAppBar> createState() => _DisneySliverAppBarState();
}

class _DisneySliverAppBarState extends State<DisneySliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      primary: false,
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xffd0d7de),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent, // Set to transparent
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: titleTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}