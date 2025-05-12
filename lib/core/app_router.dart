import 'package:elm_task/features/auth/presentation/pages/login_page.dart';
import 'package:elm_task/features/auth/presentation/pages/verify_page.dart';
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
      initialLocation:
          sl<GetStorage>().hasData(kVerify) ? Routes.incidents : Routes.login,
      routes: [
        GoRoute(
          name: Routes.login,
          path: Routes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          name: Routes.verify,
          path: Routes.verify,
          builder: (context, state) => VerifyPage(email: state.extra as String),
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
