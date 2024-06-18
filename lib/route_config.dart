import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pokdex/presentation/views/detail_screen.dart';

import 'presentation/views/home_screen.dart';

final routeConfig = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/:id',
    pageBuilder: (context, state) {
      // slide animation
      return CustomTransitionPage(
          child: DetailScreen(
            id: state.pathParameters['id'],
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          });
    },
  ),
]);
