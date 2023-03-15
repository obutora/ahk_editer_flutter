import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'animation/fade.dart';
import 'screen/about_screen.dart';
import 'screen/home_screen.dart';
import 'screen/output_screen.dart';
import 'screen/soap_edit_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => const MaterialPage(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FadeAnimation(
            // moveDirection: MoveDirection.topIn,
            child: HomeScreen(),
          ),
        ),
      ),
      // builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'edit',
      path: '/edit',
      pageBuilder: (context, state) => const MaterialPage(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FadeAnimation(
            child: SoapEditScreen(),
          ),
        ),
      ),
    ),
    GoRoute(
      name: 'output',
      path: '/output',
      pageBuilder: (context, state) => const MaterialPage(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FadeAnimation(
            child: OutputScreen(),
          ),
        ),
      ),
    ),
    GoRoute(
      name: 'about',
      path: '/about',
      pageBuilder: (context, state) => const MaterialPage(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FadeAnimation(
            child: AboutScreen(),
          ),
        ),
      ),
    ),
  ],
  errorBuilder: (context, state) => const Text('error'),
);
