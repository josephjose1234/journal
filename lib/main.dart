import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'homePage.dart';

//add launchScreen in myApp then to HomeScreen;;
void main() {
  runApp( 
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage()
    );
  }
}

