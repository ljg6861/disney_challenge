import 'package:disney_challenge/screens/select_guests/models/guest.dart';

class GuestData {
  final List<Guest> guestsWithReservation;
  final List<Guest> guestsWithoutReservation;

  GuestData(this.guestsWithReservation, this.guestsWithoutReservation);
}