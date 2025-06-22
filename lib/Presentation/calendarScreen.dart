import 'package:attireit/utils/appBar.dart';
import 'package:attireit/utils/colors.dart';
import 'package:flutter/material.dart';

class Calendarscreen extends StatelessWidget {
  const Calendarscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Text(
          'calendarScreen',
          style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
        ),
      ),
    );
  }
}
