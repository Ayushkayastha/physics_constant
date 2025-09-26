import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // Load your existing JSON
  final String response = await rootBundle.loadString('assets/constants_data.json');
  final Map<String, dynamic> constantsData = json.decode(response);

  runApp(ProviderScope(
    child: MyApp(constantsData: constantsData),
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> constantsData;
  const MyApp({super.key, required this.constantsData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physics Constants',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
      ),
      // Pass JSON data to PhysicsConstantsPage
      home: HomePagePage(constantsData: constantsData),
    );
  }
}
