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
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: kToolbarHeight, // App bar height at the top
        maxHeight: MediaQuery.of(context).padding.top + kToolbarHeight, // Larger size when it's in the page
        child: AppBar(
          centerTitle: false,
          title: Text(widget.title, style: const TextStyle(color: titleTextColor, fontSize: 18, fontWeight: FontWeight.w800)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({required this.minHeight, required this.maxHeight, required this.child});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double currentSize = max(maxHeight + shrinkOffset, minHeight);
    return SizedBox(height: currentSize, child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
