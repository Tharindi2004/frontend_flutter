class Reminder {
  final String id;
  final String title;
  final DateTime date;
  final String description;

  Reminder({
    required this.id,
    required this.title,
    required this.date,
    required this.description, required double amount, required String category,
  });
}
