import 'package:h_food/core/view/animated_splash_page.dart';
import 'package:h_food/features/info/presentation/pages/info_details_page.dart';
import 'package:h_food/features/products/presentation/screens/create_order_page.dart';
import 'package:h_food/features/products/presentation/screens/order_summary_page.dart';

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
            type: AnimatedSplashType.staticDuration,
          ),
        ),
        GoRoute(
          name: Routes.info,
          path: Routes.info,
          builder: (context, state) => const InfoDetailsPage(),
        ),
        GoRoute(
            name: Routes.createOrder,
            path: Routes.createOrder,
            builder: (context, state) => CreateOrderPage(
                  totalCal: state.extra as num,
                )),
        GoRoute(
          name: Routes.orderSummary,
          path: Routes.orderSummary,
          builder: (context, state) => OrderSummaryPage(
            totalCal: state.extra as num,
          ),
        )
      ]);
}
