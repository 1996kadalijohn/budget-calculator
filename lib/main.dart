import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const BudgetCalculatorApp());
}

class BudgetCalculatorApp extends StatelessWidget {
  const BudgetCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return MaterialApp.router(
      title: 'Budget Calculator',
      theme: baseTheme.copyWith(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2563EB),
          secondary: Color(0xFF16A34A),
          surface: Colors.white,
          error: Color(0xFFDC2626),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      ),
      routerConfig: appRouter,
    );
  }
}
