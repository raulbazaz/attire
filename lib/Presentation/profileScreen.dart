import 'package:attireit/Presentation/loginAuth.dart';
import 'package:attireit/Presentation/providers/auth_provider.dart';
import 'package:attireit/utils/appBar.dart';
import 'package:attireit/utils/colors.dart';
import 'package:attireit/utils/weather_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  User? get currentUser => Supabase.instance.client.auth.currentUser;
  String? get userName => currentUser?.userMetadata?['full_name'] as String?;

  void logout() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider.logout().then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loginauth()),
        (route) => false,
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $error')),
      );
    });
  }

  void spotifyButton() {
    // add functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(),
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
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 311,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[350],
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName ?? 'Guest',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.secondaryColor),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      logout();
                                    },
                                    child: Text('Log Out',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.secondaryColor)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WeatherContainer(location: 'New Delhi'),
                        const SizedBox(width: 20),
                        Container(
                          height: 154,
                          width: 146,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/assets/images/spotifyicon.png',
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Songs according to your style',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.secondaryColor)),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 90),
                                child: GestureDetector(
                                  onTap: () {
                                    spotifyButton();
                                  },
                                  child: Icon(Icons.arrow_circle_right_outlined,
                                      size: 30, color: AppColors.spotifyColor),
                                ),
                              ),
                            ],
                          ),
                        ),
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
