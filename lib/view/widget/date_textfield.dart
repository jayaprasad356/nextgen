import 'package:flutter/material.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/dimensions.dart';

class DateTextField extends StatelessWidget {
  final TextEditingController controller;

  DateTextField({required this.controller});

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
              borderSide: const BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          style: const TextStyle(
              fontFamily: 'MontserratBold',
              color: kTextDarkColor,
              fontSize: Dimensions.FONT_SIZE_DEFAULT),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2020),
    );
    if (picked != null && picked != controller.text) {
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      controller.text = formattedDate;
    }
  }
}