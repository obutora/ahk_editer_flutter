import 'package:ahk_editor_flutter/animation/fade.dart';
import 'package:ahk_editor_flutter/screen/about_screen.dart';
import 'package:ahk_editor_flutter/screen/home_screen.dart';
import 'package:ahk_editor_flutter/screen/output_screen.dart';
import 'package:ahk_editor_flutter/screen/soap_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: Router()));
}

class Router extends StatelessWidget {
  const Router({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: '',
    );
  }
}
