import 'package:disney_challenge/constants/strings.dart';
import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list_sliver_app_bar.dart';
import 'package:disney_challenge/widgets/layout/disney_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class SelectGuestsScreen extends StatefulWidget {
  final List<Guest> guests;

  const SelectGuestsScreen({super.key, required this.guests});

  @override
  State<SelectGuestsScreen> createState() => _SelectGuestsScreenState();
}

class _SelectGuestsScreenState extends State<SelectGuestsScreen> {
  final List<Guest> guestsWithReservation = [];
  final List<Guest> guestsWithoutReservation = [];
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    List<Guest> sortableList = [...widget.guests];
    for (var guest in sortableList) {
      if (guest.hasReservation) {
        guestsWithReservation.add(guest);
      } else {
        guestsWithoutReservation.add(guest);
      }
    }
  }

  @override
  void didChangeDependencies() {
    controller = ScrollController(initialScrollOffset: MediaQuery.of(context).padding.top);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomScrollView(
            controller: controller,
            slivers: [
              const DisneySliverAppBar(title: selectGuests),
              const UserSliverListAppBar(title: theseGuestsHaveReservations),
              UserListWidget(guests: guestsWithReservation, ),
              const UserSliverListAppBar(title: theseGuestsNeedReservations),
              UserListWidget(guests: guestsWithoutReservation,)
            ],
          ),
        ),
      ),
    );
  }
}
