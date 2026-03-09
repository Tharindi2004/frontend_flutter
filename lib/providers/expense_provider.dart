import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  double get totalMonthlyExpense {
    return _expenses.fold(0, (sum, item) => sum + item.amount);
  }

  Object? getTotalForMonth(DateTime selectedMonth) {
    return null;
  }

  Object? getCategoryTotals(DateTime selectedMonth) {
    return null;
  }
}
