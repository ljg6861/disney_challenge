import 'dart:math';

import 'package:disney_challenge/constants/colors.dart';
import 'package:flutter/material.dart';

class UserSliverListAppBar extends StatefulWidget {
  final String title;

  const UserSliverListAppBar({super.key, required this.title});

  @override
  State<UserSliverListAppBar> createState() => _UserSliverListAppBarState();
}

class _UserSliverListAppBarState extends State<UserSliverListAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      primary: false,
      centerTitle: false,
      title: Text(widget.title,
          style: const TextStyle(
              color: titleTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w800)),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
    );
  }
}
