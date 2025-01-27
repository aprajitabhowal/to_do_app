import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'GroceryListScreen.dart';

/// This class defines the global theme for the app, including color schemes
/// and text styles. The app's home screen is set to `GroceryListScreen`.
class MyApp extends StatelessWidget {
  /// Method to build the app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.orange,
        ),
        scaffoldBackgroundColor: Color(0xFFFFFAF0),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: GroceryListScreen() as Widget,
    );
  }
}
