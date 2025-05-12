import 'package:elm_task/core/view/animated_splash_page.dart';
import 'package:elm_task/features/bus_track/presentation/screens/bus_tracks_page.dart';
import 'package:elm_task/features/incidents/presentation/pages/dashboard_page.dart';
import 'package:elm_task/features/incidents/presentation/pages/incidents_page.dart';

import '../../export.dart';

/// don't use for navigate without context
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  /// use for navigate without context
  static final GoRouter routes = GoRouter(
      navigatorKey: navKey,
      initialLocation: Routes.animatedSplash,
      routes: [
        GoRoute(
          name: Routes.animatedSplash,
          path: Routes.animatedSplash,
          builder: (context, state) => AnimatedSplash(
            home: Routes.info,
            title: '',
            duration: Duration.hoursPerDay,
            type: AnimatedSplashType.StaticDuration,
          ),
        ),
        GoRoute(
          name: Routes.incidents,
          path: Routes.incidents,
          builder: (context, state) => const IncidentsPage(),
        ),
        GoRoute(
          name: Routes.dashboard,
          path: Routes.dashboard,
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
            name: Routes.busTracks,
            path: Routes.busTracks,
            builder: (context, state) => BusTracksPage(
                  id: state.extra as String,
                )),
      ]);
}
