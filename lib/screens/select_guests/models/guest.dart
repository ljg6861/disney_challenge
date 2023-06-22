class Guest {
  final String name;
  bool hasReservation;
  bool isSelected;

  Guest({required this.name, required this.hasReservation, this.isSelected = false});
}
