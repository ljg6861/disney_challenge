class Guest {
  final String name;
  final String id;
  bool hasReservation;
  bool isSelected;

  Guest(
      {required this.name,
      required this.hasReservation,
      this.isSelected = false,
      required this.id});
}
