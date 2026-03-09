import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/reminder.dart';
import '../../providers/reminder_provider.dart';

class ReminderDetailsScreen extends StatefulWidget {
  final DateTime initialDate;

  const ReminderDetailsScreen({super.key, required this.initialDate});

  @override
  State<ReminderDetailsScreen> createState() => _ReminderDetailsScreenState();
}

class _ReminderDetailsScreenState extends State<ReminderDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String selectedCategory = "general";

  Map<String, IconData> categoryIcons = {
    "general": Icons.notifications,
    "supermarket": Icons.shopping_cart,
    "vehicle": Icons.directions_car,
    "bill": Icons.receipt_long,
    "food": Icons.restaurant,
    "health": Icons.favorite,
  };

  late DateTime selectedDate;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  // ---------------- DATE PICKER ----------------
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // ---------------- TIME PICKER ----------------
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy').format(selectedDate);

    final formattedTime = selectedTime.format(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Reminder Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- TITLE ----------------
            const Text("Title", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),

            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Pay credit card",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- TYPE & AMOUNT (for simplicity, we hardcode these) ----------------
            // Amount Label
            const SizedBox(height: 16),
            const Text(
              "Amount",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 8),

            // Amount TextField
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "e.g. 5000",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixText: "Rs ",
                prefixStyle: const TextStyle(color: Colors.green),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            // ---------------- DATE & TIME ----------------
            const Text("Date & Time", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),

            Row(
              children: [
                // DATE BUTTON
                Expanded(
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 33, 33),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            formattedDate,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // TIME BUTTON
                Expanded(
                  child: GestureDetector(
                    onTap: _pickTime,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.access_time, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            formattedTime,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ---------------- NOTES ----------------
            const Text("Notes", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),

            TextField(
              controller: _notesController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "e.g online payment",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CATEGORY ICON SELECTOR STARTS HERE
            const Text("Category", style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 10),

            Wrap(
              spacing: 12,
              children: categoryIcons.entries.map((entry) {
                bool isSelected = selectedCategory == entry.key;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = entry.key;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      entry.value,
                      color: isSelected ? Colors.black : Colors.grey,
                      size: 26,
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // ---------------- SAVE BUTTON ----------------
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_titleController.text.isEmpty) return;

                  final reminder = Reminder(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: _titleController.text,
                    category: selectedCategory,
                    amount: double.tryParse(amountController.text) ?? 0.0,
                    date: selectedDate,
                    description: _notesController.text,
                  );

                  Provider.of<ReminderProvider>(
                    context,
                    listen: false,
                  ).addReminder(reminder);

                  Navigator.pop(context);
                },
                child: const Text(
                  "Save Reminder",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
