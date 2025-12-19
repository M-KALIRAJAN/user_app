import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final DateTime? firstDate;
  final Function(DateTime)? onDateSelected;

  const AppDatePicker({
    super.key,
    required this.controller,
    this.label = "Select Date",
    this.firstDate,
    this.onDateSelected,
  });

  Future<void> _pickDate(BuildContext context) async {
    DateTime today = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: firstDate ?? today,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = DateFormat("dd MMM yyyy").format(pickedDate);

      if (onDateSelected != null) {
        onDateSelected!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => _pickDate(context),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
