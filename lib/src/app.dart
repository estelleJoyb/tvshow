import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvshow/src/auth.dart';
import 'package:tvshow/src/constants/constants.dart';
import 'package:tvshow/src/screens/scaffold.dart';
import 'package:tvshow/src/screens/settings.dart';
import 'package:tvshow/src/screens/sign_in.dart';
import 'package:tvshow/src/screens/sign_up.dart';
import 'package:tvshow/src/screens/tvshow_detail.dart';
import 'package:tvshow/src/screens/tvshow_research.dart';

import 'package:tvshow/src/widgets/fade_transition_page.dart';
import 'package:tvshow/src/widgets/tvshow_list.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');

class TvShowApp extends StatefulWidget {
  const TvShowApp({super.key});

  @override
  State<TvShowApp> createState() => _TvShowAppState();
}

class _TvShowAppState extends State<TvShowApp> {
  final TvShowAuth auth = TvShowAuth();
 // int _tabControllerIndex = 2;

  String? getRedirectPath(Uri stateUri, bool signedIn) {
    final currentPath = stateUri.toString();
    final excludedPaths = ['/sign-in', '/sign-up'];

    if (!excludedPaths.contains(currentPath) && !signedIn) {
      return '/sign-in';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          secondary: Constants.paleGreen,
          brightness: Brightness.dark,
          primary: Constants.taupeGray,
          surface: Constants.brown,
          onPrimary: Constants.brown,
        ),
      ),
      builder: (context, child) {
        if (child == null) {
          throw ('No child in .router constructor builder');
        }
        return TvShowAuthScope(notifier: auth, child: child);
      },
      routerConfig: GoRouter(
        refreshListenable: auth,
        debugLogDiagnostics: true,
        initialLocation: '/',
        redirect: (context, state) {
          final signedIn = TvShowAuth.of(context).signedIn;
          return getRedirectPath(state.uri, signedIn);
        },
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) => '/shows',
          ),
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return TvShowstoreScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/shows') => 0,
                  var p when p.startsWith('/settings') => 1,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: '/shows',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: const TvShowResearch()
                  );
                },
              ),
              GoRoute(
                  path: '/shows/:showId',
                  builder: (context, state){
                    final showId = state.pathParameters['showId'] ?? "0";
                    return TvShowDetailsScreen(showId: showId,);
                  }
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: const SettingsScreen(),
                  );
                },
              ),

             /* GoRoute(
                path: '/champignon/:champignonId',
                builder: (context, state) {
                  return ChampignonDetailsScreen(
                    champignon: libraryInstance.getChampignon(
                      state.pathParameters['champignonId'] ?? '',
                    ),
                  );
                },
              ),*/


            ],
          ),
          GoRoute(
            path: '/sign-in',
            builder: (context, state) {
              return SignInScreen(
                onSignIn: (value) async {
                  final router = GoRouter.of(context);
                  await TvShowAuth.of(context).signIn(value.username, value.password);
                  router.go('/');
                },
              );
            },
          ),
          GoRoute(
            path: '/sign-up',
            builder: (context, state) {
              return SignUpScreen(
                onSignUp: (value) async {
                  final router = GoRouter.of(context);
                  await TvShowAuth.of(context).signIn(value.username, value.password);
                  router.go('/');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}