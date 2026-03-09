import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/reminder_provider.dart';
import '../../widgets/reminder_card.dart';
import 'reminder_details_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
        //ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: Builder(
        builder: (context) {
          final reminderProvider = Provider.of<ReminderProvider>(context);

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReminderDetailsScreen(
                      initialDate: reminderProvider.focusedDate,
                    ),
                  ),
                );
              },
            ),
            appBar: AppBar(title: const Text("Calendar & Reminders")),
            body: Container(
              color: const Color(0xFF121212),
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2035),
                    focusedDay: reminderProvider.selectedDate,
                    selectedDayPredicate: (day) {
                      return isSameDay(day, reminderProvider.selectedDate);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      reminderProvider.selectDate(selectedDay);
                    },
                    eventLoader: (day) {
                      final reminders = reminderProvider.getRemindersForDate(
                        day,
                      );
                      return reminders.map((reminder) => reminder).toList();
                    },
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.green,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.green,
                      ),
                    ),
                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                      outsideTextStyle: TextStyle(color: Colors.grey),
                      selectedDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      markersMaxCount: 3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer<ReminderProvider>(
                      builder: (context, provider, child) {
                        final reminders = provider.getRemindersForDate(
                          provider.selectedDate,
                        );

                        if (reminders.isEmpty) {
                          return const Center(
                            child: Text(
                              "No reminders for this date",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: reminders.length,
                          itemBuilder: (context, index) {
                            final reminder = reminders[index];
                            return ReminderCard(reminder: reminder);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

extension on Widget {
  // ignore: unused_element
  int? get length => null;

  // ignore: unused_element
  bool? get isEmpty => null;
}
