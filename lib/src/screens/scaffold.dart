import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TvShowstoreScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const TvShowstoreScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: child,
        onDestinationSelected: (idx) {
          if (idx == 0) goRouter.go('/shows');
          if (idx == 1) goRouter.go('/settings');
        },
        destinations:  const [
          AdaptiveScaffoldDestination(title: 'Shows', icon: Icons.movie),
          AdaptiveScaffoldDestination(title: 'Settings', icon: Icons.settings),
        ],
      ),
    );
  }
}