import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:disney_challenge/screens/select_guests/models/guest_data.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/continue_button_facade.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/disabled_continue_button_manager.dart';
import 'package:disney_challenge/screens/select_guests/widgets/continue_button/enabled_continue_button_manager.dart';
import 'dart:async';

class SelectGuestsBloc {
  final _guestDataController = StreamController<GuestData>.broadcast();
  final _guestsWithReservationController = StreamController<List<Guest>>();
  final _guestsWithoutReservationController = StreamController<List<Guest>>();
  late GuestData _currentValue;

  Stream<GuestData> get guestDataStream => _guestDataController.stream;

  Stream<List<Guest>> get guestWithReservationStream =>
      _guestsWithReservationController.stream;

  Stream<List<Guest>> get guestWithoutReservationStream =>
      _guestsWithoutReservationController.stream;

  SelectGuestsBloc(List<Guest> guests) {
    List<Guest> guestsWithReservation = [];
    List<Guest> guestsWithoutReservation = [];

    for (var guest in guests) {
      if (guest.hasReservation) {
        guestsWithReservation.add(guest);
      } else {
        guestsWithoutReservation.add(guest);
      }
    }

    guestDataStream.listen((event) {
      _currentValue = event;
    });

    _guestDataController
        .add(GuestData(guestsWithReservation, guestsWithoutReservation));
    _guestsWithReservationController.add(guestsWithReservation);
    _guestsWithoutReservationController.add(guestsWithoutReservation);
  }

  ContinueButtonFacade getButtonManager() {
    final guestData = _currentValue;
    List<Guest> selectedGuestsWithReservations = guestData.guestsWithReservation
        .where((element) => element.isSelected)
        .toList();
    List<Guest> selectedGuestsWithoutReservations = guestData
        .guestsWithoutReservation
        .where((element) => element.isSelected)
        .toList();

    if (selectedGuestsWithReservations.isNotEmpty ||
        selectedGuestsWithoutReservations.isNotEmpty) {
      return EnabledContinueButtonManager();
    } else {
      return DisabledContinueButtonManager();
    }
  }

  void updateGuestSelection(Guest guest) {
    final guestData = _currentValue;
    List<Guest> listToUpdate;
    StreamController streamToUpdate;
    if (guest.hasReservation) {
      listToUpdate = guestData.guestsWithReservation;
      streamToUpdate = _guestsWithReservationController;
    } else {
      listToUpdate = guestData.guestsWithoutReservation;
      streamToUpdate = _guestsWithoutReservationController;
    }
    int index = listToUpdate.indexWhere((element) => element.id == guest.id);
    listToUpdate[index] = guest;
    _guestDataController.add(guestData);
    streamToUpdate.add(listToUpdate);
  }

  void dispose() {
    _guestDataController.close();
  }
}
