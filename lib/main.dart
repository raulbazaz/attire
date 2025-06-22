import 'package:attireit/Presentation/loginAuth.dart';
import 'package:attireit/Presentation/providers/auth_provider.dart';
import 'package:attireit/Presentation/providers/weather_provider.dart';

import 'package:attireit/data/auth_remote_datasource.dart';
import 'package:attireit/data/auth_repository_impl.dart';
import 'package:attireit/data/weather_api_service.dart';
import 'package:attireit/data/weather_repository_impl.dart';

import 'package:attireit/domain/logout_user.dart';
import 'package:attireit/domain/signup_user.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://hcshpgiaiaqeqzjolabk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhjc2hwZ2lhaWFxZXF6am9sYWJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA0OTA2NDMsImV4cCI6MjA2NjA2NjY0M30.MsZkLRCepIDC4dnFwhyiBbIcgfG0ZYZ2cdIFPdfL-lA',
  );

  // Initialize dependencies
  final supabaseClient = Supabase.instance.client;

  // Auth dependencies
  final authRemoteDatasource = AuthRemoteDatasourceImpl(supabaseClient);
  final authRepository = AuthRepositoryImpl(authRemoteDatasource);
  final logoutUser = LogoutUser(authRepository);
  final signUpUser = SignUpUser(authRepository);

  runApp(
    MultiProvider(
      providers: [
        // Weather Provider
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(
            WeatherRepositoryImpl(
              WeatherApiService('5006c944606546a188e125639252106'),
            ),
          ),
        ),

        // Auth Provider
        ChangeNotifierProvider(
          create: (_) => AuthProvider(logoutUser, signUpUser),
        ),

        // Other providers...
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginauth(),
      theme: ThemeData(
        textTheme: GoogleFonts.gideonRomanTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
