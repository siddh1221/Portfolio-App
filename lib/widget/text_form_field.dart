import 'package:flutter/material.dart';

import '../core/colors/app_color.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      this.maxLines = 1,
      required this.label});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLines: maxLines,
      controller: controller,
      cursorColor: AppColor.black,
      style: const TextStyle(color: AppColor.black),
      decoration: InputDecoration(
          hintStyle: const TextStyle(color: AppColor.black),
          label: Text(
            label,
            style: const TextStyle(
                color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.black)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.black)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.black)),
          fillColor: Colors.transparent),
    );
  }
}
