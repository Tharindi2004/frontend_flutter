import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderProvider with ChangeNotifier {
  final List<Reminder> _reminders = [];

  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  List<Reminder> get reminders => _reminders;

  DateTime get selectedDate => _selectedDate;
  DateTime get focusedDate => _focusedDate;

  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void deleteReminder(String id) {
    _reminders.removeWhere((reminder) => reminder.id == id);
    notifyListeners();
  }

  void selectDate(DateTime selectedDay) {
    _selectedDate = selectedDay;
    _focusedDate = selectedDay;
    notifyListeners();
  }

  List<Reminder> getRemindersForDate(DateTime day) {
    return _reminders.where((reminder) {
      return reminder.date.year == day.year &&
          reminder.date.month == day.month &&
          reminder.date.day == day.day;
    }).toList();
  }
}
