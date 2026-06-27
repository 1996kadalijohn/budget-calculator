import 'package:go_router/go_router.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/welcome_screen.dart';
import '../features/dashboard/screens/main_navigation_screen.dart';
import '../features/expense/screens/expense_screen.dart';
import '../features/income/screens/income_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/reports/screens/reports_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const MainNavigationScreen(),
      routes: [
        GoRoute(
          path: 'home',
          name: 'home',
          builder: (context, state) => const MainNavigationScreen(),
        ),
        GoRoute(
          path: 'income',
          name: 'income',
          builder: (context, state) => const IncomeScreen(),
        ),
        GoRoute(
          path: 'expense',
          name: 'expense',
          builder: (context, state) => const ExpenseScreen(),
        ),
        GoRoute(
          path: 'reports',
          name: 'reports',
          builder: (context, state) => const ReportsScreen(),
        ),
        GoRoute(
          path: 'profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
