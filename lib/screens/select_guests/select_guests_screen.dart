import 'package:disney_challenge/constants/strings.dart';
import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:disney_challenge/screens/select_guests/models/guest_data.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button_facade.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/disabled_continue_button_manager.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/enabled_continue_button_manager.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list_sliver_app_bar.dart';
import 'package:disney_challenge/widgets/layout/disney_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectGuestsScreen extends StatefulWidget {
  final List<Guest> guests;

  const SelectGuestsScreen({super.key, required this.guests});

  @override
  State<SelectGuestsScreen> createState() => _SelectGuestsScreenState();
}

class _SelectGuestsScreenState extends State<SelectGuestsScreen> {
  late final ValueNotifier<GuestData> guestDataNotifier;
  final GlobalKey bottomListViewKey = GlobalKey();
  bool firstPinned = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    List<Guest> guestsWithReservation = [];
    List<Guest> guestsWithoutReservation = [];

    for (var guest in widget.guests) {
      if (guest.hasReservation) {
        guestsWithReservation.add(guest);
      } else {
        guestsWithoutReservation.add(guest);
      }
    }

    guestDataNotifier = ValueNotifier(GuestData(guestsWithReservation, guestsWithoutReservation));

    controller.addListener(() {
      scrollListener();
    });
    super.initState();
  }

  void scrollListener() {
    var keyContext = bottomListViewKey.currentContext;
    if (keyContext != null) {
      final sliverList = keyContext.findRenderObject() as RenderSliverList;
      final child = sliverList.firstChild;
      final box = child?.localToGlobal(Offset.zero);
      if (box == null) {
        return;
      }
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
  void dispose() {
    guestDataNotifier.dispose();
    super.dispose();
  }

  ContinueButtonFacade getButtonManager(GuestData data) {
    List<Guest> selectedGuestsWithReservations =
        data.guestsWithReservation.where((element) => element.isSelected).toList();
    List<Guest> selectedGuestsWithoutReservations =
        data.guestsWithoutReservation.where((element) => element.isSelected).toList();

    if (selectedGuestsWithReservations.isNotEmpty || selectedGuestsWithoutReservations.isNotEmpty) {
      return EnabledContinueButtonManager();
    } else {
      return DisabledContinueButtonManager();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Guest> guestsWithReservation = guestDataNotifier.value.guestsWithReservation;
    List<Guest> guestsWithOutReservation = guestDataNotifier.value.guestsWithoutReservation;

    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        ValueListenableBuilder<GuestData>(
          valueListenable: guestDataNotifier,
          builder: (context, guestData, child) {
            return ContinueButton(
              manager: getButtonManager(guestData),
            );
          },
        ),
      ],
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
                onGuestListUpdated: () => guestsWithReservation.value = List.from(guestsWithReservation.value),
              ),
              UserSliverListAppBar(title: theseGuestsNeedReservations, pinned: !firstPinned),
              UserListWidget(guests: guestsWithoutReservation, key: bottomListViewKey)
            ],
          ),
        ),
      ),
    );
  }
}
