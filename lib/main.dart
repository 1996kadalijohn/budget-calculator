import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/auth/services/auth_service.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const BudgetCalculatorApp());
}

class BudgetCalculatorApp extends StatelessWidget {
  const BudgetCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.light(useMaterial3: true);
    final authService = AuthService();
    final repository = FirebaseAuthRepository(authService: authService);

    return ChangeNotifierProvider(
      create: (_) => AppAuthProvider(repository: repository),
      child: MaterialApp.router(
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
      ),
    );
  }
}
