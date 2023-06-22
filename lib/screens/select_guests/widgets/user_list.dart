import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserListWidget extends StatefulWidget {
  final List<Guest> guests;

  const UserListWidget({super.key, required this.guests});

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      Guest currentGuest = widget.guests[index];

      return UserListTile(guest: currentGuest);
    }, childCount: widget.guests.length, ));
  }
}
