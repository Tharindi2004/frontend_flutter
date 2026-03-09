import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;

  const ReminderCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(reminder.title),
        subtitle: Text(reminder.description),
        trailing: Text(
          "${reminder.date.day}/${reminder.date.month}/${reminder.date.year}",
        ),
      ),
    );
  }
}
