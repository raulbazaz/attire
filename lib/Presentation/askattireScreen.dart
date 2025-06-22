import 'package:attireit/utils/colors.dart';
import 'package:flutter/material.dart';

class Askattirescreen extends StatelessWidget {
  const Askattirescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Text(
          'askAttireScreen',
          style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
        ),
      ),
    );
  }
}
