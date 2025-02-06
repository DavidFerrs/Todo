import 'package:go_router/go_router.dart';
import 'package:wl_challenge/app/core/navigation/app_constants.dart';
import 'package:wl_challenge/app/core/ui/widgets/app_default_page.dart';
import 'package:wl_challenge/app/modules/todo/views/done_view.dart';
import 'package:wl_challenge/app/modules/todo/views/home_view.dart';
import 'package:wl_challenge/app/modules/todo/views/search_view.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = GoRouter(
    initialLocation: RoutesConstants.home,
    routes: <RouteBase>[
      ShellRoute(
          builder: (context, state, child) {
            return AppDefaultPage(
              child: child,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: RoutesConstants.home,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeView(),
              ),
            ),
            GoRoute(
              path: RoutesConstants.create,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeView(),
              ),
            ),
            GoRoute(
              path: RoutesConstants.search,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchView(),
              ),
            ),
            GoRoute(
              path: RoutesConstants.done,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DoneView(),
              ),
            ),
          ]),
    ],
  );
}
