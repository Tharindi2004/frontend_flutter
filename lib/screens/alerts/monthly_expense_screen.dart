// ignore_for_file: unused_local_variable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';

class MonthlySummaryScreen extends StatefulWidget {
  const MonthlySummaryScreen({super.key});

  @override
  State<MonthlySummaryScreen> createState() => _MonthlySummaryScreenState();
}

Widget _buildRecentTransactions(ExpenseProvider provider) {
  final recent = provider.expenses.reversed.take(5);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      const Text(
        "Recent Transactions",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      ...recent.map((expense) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shopping_bag, color: Colors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "-\$${expense.amount.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      }).toList(),
    ],
  );
}

class _MonthlySummaryScreenState extends State<MonthlySummaryScreen> {
  DateTime selectedMonth = DateTime.now();
  double monthlyBudget = 2500;

  Widget _buildDonutChart(Map<String, double> categoryData, double total) {
    List<Color> colors = [
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];

    int index = 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 60,
                sections: categoryData.entries.map((entry) {
                  final value = entry.value;
                  final percent = total == 0 ? 0.0 : (value / total) * 100;

                  final section = PieChartSectionData(
                    color: colors[index % colors.length],
                    value: value,
                    title: "",
                    radius: 25,
                  );

                  index++;
                  return section;
                }).toList(),
              ),
              // ignore: deprecated_member_use
              swapAnimationDuration: const Duration(milliseconds: 800),
              // ignore: deprecated_member_use
              swapAnimationCurve: Curves.easeInOut,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Total Spent", style: TextStyle(color: Colors.grey)),
                Text(
                  "\$${total.toStringAsFixed(1)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final total = expenseProvider.getTotalForMonth(selectedMonth);
    final categoryData =
        (expenseProvider.getCategoryTotals(selectedMonth) ?? {})
            as Map<String, double>;

    double percentUsed;
    if (monthlyBudget == 0) {
      percentUsed = 0;
    } else {
      percentUsed = (total ?? 0).toDouble() / monthlyBudget.toDouble();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        selectedMonth = DateTime(
                          selectedMonth.year,
                          selectedMonth.month - 1,
                        );
                      });
                    },
                  ),
                  Text(
                    "${_getMonthName(selectedMonth.month)} ${selectedMonth.year}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        selectedMonth = DateTime(
                          selectedMonth.year,
                          selectedMonth.month + 1,
                        );
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// 🔹 TOTAL SPENT CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Spent",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\Rs${((total ?? 0) as double).toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildDonutChart(categoryData, total as double),
                    const SizedBox(height: 25),

                    /// Progress Bar
                    LinearProgressIndicator(
                      value: percentUsed > 1 ? 1 : percentUsed,
                      backgroundColor: Colors.grey.shade800,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "vs. \$${monthlyBudget.toStringAsFixed(0)} Budget",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          "${(percentUsed * 100).toStringAsFixed(0)}% Used",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// 🔹 CATEGORY TITLE
              const Text(
                "Category Spending",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              /// 🔹 CATEGORY LIST
              Expanded(
                child: categoryData.isEmpty
                    ? const Center(
                        child: Text(
                          "No expenses this month",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView(
                        children: categoryData.entries.map((entry) {
                          double categoryPercent = total == 0
                              ? 0
                              : (entry.value / (total)) * 100;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1E),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.category,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.key,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\$${entry.value.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${categoryPercent.toStringAsFixed(0)}%",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
              _buildRecentTransactions(expenseProvider),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Helper Function for Month Name
  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }
}

extension on Object {
  toDouble() {}
}
