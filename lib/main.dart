//import 'package:SaveOnix/screens/alerts/calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/reminder_provider.dart';
import 'providers/expense_provider.dart';

import 'screens/alerts/monthly_expense_screen.dart';
import 'screens/alerts/calendar_screen.dart';
import 'screens/alerts/notifications_alerts_screen.dart';

void main() {
  runApp(const SaveOnixApp());
}

class SaveOnixApp extends StatelessWidget {
  const SaveOnixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SaveOnix',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    //ReminderScreen(),
    CalendarScreen(),
    NotificationsScreen(),
    MonthlySummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Summary",
          ),
        ],
      ),
    );
  }
}

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
