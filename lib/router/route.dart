import 'package:go_router/go_router.dart';
import 'package:water_tracker/features/main_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainScreen()),
  ],
);
