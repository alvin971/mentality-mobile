import 'package:go_router/go_router.dart';
import '../features/landing/presentation/pages/landing_page.dart';
import '../features/landing/presentation/pages/confirmation_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/confirmation',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final placeNumber = extra?['placeNumber'] as int?;
        final prenom = extra?['prenom'] as String? ?? '';
        return ConfirmationPage(placeNumber: placeNumber, prenom: prenom);
      },
    ),
  ],
);
