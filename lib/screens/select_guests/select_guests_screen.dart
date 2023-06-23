import 'package:disney_challenge/constants/strings.dart';
import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list_sliver_app_bar.dart';
import 'package:disney_challenge/widgets/layout/disney_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class SelectGuestsScreen extends StatefulWidget {
  final List<Guest> guests;

  const SelectGuestsScreen({super.key, required this.guests});

  @override
  State<SelectGuestsScreen> createState() => _SelectGuestsScreenState();
}

class _SelectGuestsScreenState extends State<SelectGuestsScreen> {
  final List<Guest> guestsWithReservation = [];
  final List<Guest> guestsWithoutReservation = [];
  final GlobalKey bottomListViewKey = GlobalKey();
  bool firstPinned = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    List<Guest> sortableList = [...widget.guests];
    for (var guest in sortableList) {
      if (guest.hasReservation) {
        guestsWithReservation.add(guest);
      } else {
        guestsWithoutReservation.add(guest);
      }
    }

    controller.addListener(() {
      scrollListener();
    });
    super.initState();
  }

  void scrollListener(){
    var keyContext = bottomListViewKey.currentContext;
    if (keyContext != null) {
      final sliverList = keyContext.findRenderObject() as RenderSliverList;
      final child = sliverList.firstChild;
      final box = child!.localToGlobal(Offset.zero);
      if (box.dy < 150) {
        if (firstPinned != false) {
          setState(() {
            firstPinned = false;
          });
        }
      } else {
        if (firstPinned != true) {
          setState(() {
            firstPinned = true;
          });
        }
      }
    }
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
              UserSliverListAppBar(
                title: theseGuestsHaveReservations,
                pinned: firstPinned,
              ),
              UserListWidget(
                guests: guestsWithReservation,
              ),
              UserSliverListAppBar(
                  title: theseGuestsNeedReservations, pinned: !firstPinned),
              UserListWidget(
                  guests: guestsWithoutReservation, key: bottomListViewKey)
            ],
          ),
        ),
      ),
    );
  }
}
