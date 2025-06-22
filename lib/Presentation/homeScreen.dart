import 'package:attireit/utils/appBar.dart';
import 'package:attireit/utils/colors.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
