import 'package:disney_challenge/constants/strings.dart';
import 'package:disney_challenge/screens/select_guests/bloc/guest_data_bloc.dart';
import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:disney_challenge/screens/select_guests/models/guest_data.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/disabled_continue_button_manager.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list.dart';
import 'package:disney_challenge/screens/select_guests/widgets/user_list_sliver_app_bar.dart';
import 'package:disney_challenge/widgets/layout/disney_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectGuestsScreen extends StatefulWidget {
  final List<Guest> guests;

  const SelectGuestsScreen({Key? key, required this.guests}) : super(key: key);

  @override
  State<SelectGuestsScreen> createState() => _SelectGuestsScreenState();
}

class _SelectGuestsScreenState extends State<SelectGuestsScreen> {
  late final SelectGuestsBloc _bloc;
  final GlobalKey bottomListViewKey = GlobalKey();
  bool firstPinned = true;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    _bloc = SelectGuestsBloc(widget.guests);

    controller.addListener(scrollListener);

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
    _bloc.dispose();
    controller.removeListener(scrollListener);
    super.dispose();
  }

  void updateGuestSelection(Guest guest) {
    _bloc.updateGuestSelection(guest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterAlignment: AlignmentDirectional.center,
      bottomNavigationBar: StreamBuilder<GuestData>(
        stream: _bloc.guestDataStream,
        builder: (context, guestDataSnapshot) {
          if (guestDataSnapshot.hasData) {
            var manager = _bloc.getButtonManager();

            if (manager is DisabledContinueButtonManager) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 34,
                    top: 16),
                child: ContinueButton(manager: DisabledContinueButtonManager()),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 34, top: 16),
              child: ContinueButton(
                manager: _bloc.getButtonManager(),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 34, top: 16),
              child: ContinueButton(manager: DisabledContinueButtonManager()),
            );
          }
        },
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomScrollView(
            controller: controller,
            slivers: [
              const DisneySliverAppBar(title: selectGuests),
              UserSliverListAppBar(
                title: guestsWithReservations,
                pinned: firstPinned,
              ),
              StreamBuilder<List<Guest>>(
                  stream: _bloc.guestWithReservationStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return UserListWidget(
                        guests: snapshot.data!,
                        onGuestSelected: _bloc.updateGuestSelection,
                      );
                    } else {
                      return UserListWidget(
                        guests: const [],
                        onGuestSelected: (_) {},
                      );
                    }
                  }),
              UserSliverListAppBar(
                  title: guestsWithoutReservations, pinned: !firstPinned),
              StreamBuilder<List<Guest>>(
                  stream: _bloc.guestWithoutReservationStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return UserListWidget(
                        key: bottomListViewKey,
                        guests: snapshot.data!,
                        onGuestSelected: _bloc.updateGuestSelection,
                      );
                    } else {
                      return UserListWidget(
                        guests: const [],
                        onGuestSelected: (_) {},
                      );
                    }
                  }),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Icon(
                            Icons.info,
                            color: Color(0xff132c44),
                          )),
                      const SizedBox(
                        width: 6,
                      ),
                      const Flexible(
                        child: Text(
                          atLeastOneGuestLong,
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff00233c)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
