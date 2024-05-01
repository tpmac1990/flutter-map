import 'package:my_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:my_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:my_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:my_app/src/features/map/presentation/map_screen/map_screen.dart';
import 'package:my_app/src/routing/go_router_refresh_stream.dart';
import 'package:my_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  signIn,
  map,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signIn') {
          return '/';
        }
      } else {
        // if (path == '/account' || path == '/orders') {
        return '/';
        // }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const MapScreen(),
        routes: [        
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
          GoRoute(
            path: 'map',
            name: AppRoute.map.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: MapScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
