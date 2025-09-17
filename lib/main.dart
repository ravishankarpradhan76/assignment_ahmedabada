import 'package:assignment_ahmedabad/screen/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'assignment ahmedabad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}
