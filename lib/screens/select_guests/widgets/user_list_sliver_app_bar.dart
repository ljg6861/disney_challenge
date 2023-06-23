import 'dart:math';

import 'package:disney_challenge/constants/colors.dart';
import 'package:flutter/material.dart';

class UserSliverListAppBar extends StatefulWidget {
  final String title;
  final bool pinned;

  const UserSliverListAppBar({super.key, required this.title, required this.pinned});

  @override
  State<UserSliverListAppBar> createState() => _UserSliverListAppBarState();
}

class _UserSliverListAppBarState extends State<UserSliverListAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: widget.pinned,
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
