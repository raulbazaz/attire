import 'package:attireit/Presentation/signupScreen.dart';
import 'package:attireit/utils/appBar.dart';
import 'package:attireit/utils/colors.dart';

import 'package:attireit/data/auth_remote_datasource.dart';
import 'package:attireit/data/auth_repository_impl.dart';
import 'package:attireit/domain/login_user.dart';
import 'package:attireit/utils/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Loginauth extends StatefulWidget {
  const Loginauth({super.key});

  @override
  State<Loginauth> createState() => _LoginauthState();
}

class _LoginauthState extends State<Loginauth> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final LoginUser loginUser;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    final datasource = AuthRemoteDatasourceImpl(supabase);
    final repository = AuthRepositoryImpl(datasource);
    loginUser = LoginUser(repository);
  }

  Future<void> _handleLogin() async {
    try {
      await loginUser.call(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigate after login
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Mainscreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login successful',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
            ),
          ),
          backgroundColor: AppColors.secondaryColor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid email or password',
            style: TextStyle(color: AppColors.secondaryColor, fontSize: 16),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: 375,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 40, color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Enter your E-mail',
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'E-mail',
                                hintStyle:
                                    TextStyle(color: AppColors.secondaryColor),
                                contentPadding: EdgeInsets.only(left: 30),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Enter your Password',
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle:
                                    TextStyle(color: AppColors.secondaryColor),
                                contentPadding: EdgeInsets.only(left: 30),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            _handleLogin();
                          },
                          icon: Icon(Icons.arrow_forward),
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signupscreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Don\'t have an account? Sign up',
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
