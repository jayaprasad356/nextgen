import 'package:flutter/material.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/dimensions.dart';

class DateTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final Color borderColor;
  final int startYear;
  final int endYear;

  DateTextField({required this.controller, required this.color, required this.borderColor, required this.startYear, required this.endYear});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Select Date', // Hint text
            hintStyle: const TextStyle(
                fontFamily: 'MontserratBold',
                color: kHintText,
                fontSize: Dimensions.FONT_SIZE_DEFAULT),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                width: 1,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          style: TextStyle(
              fontFamily: 'MontserratBold',
              color: color,
              fontSize: Dimensions.FONT_SIZE_DEFAULT),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(startYear),
      // firstDate: DateTime(1900),
      lastDate: DateTime(endYear),
      // lastDate: DateTime(2020),
    );
    if (picked != null && picked != controller.text) {
      String formattedDate = "${picked.year}/${picked.month}/${picked.day}";
      controller.text = formattedDate;
    }
  }
}