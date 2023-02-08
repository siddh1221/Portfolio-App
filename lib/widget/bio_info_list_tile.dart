import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BioInfoListTile extends StatelessWidget {
  const BioInfoListTile({super.key, required this.label, required this.detail});
  final String label;
  final String detail;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "$label :",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
      ),
      title: Text(
        detail,
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }
}
