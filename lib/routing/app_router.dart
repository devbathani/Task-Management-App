import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      RouteType.material(); //.cupertino, .adaptive ..etc
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: "/homeRoute", initial: true),
        AutoRoute(page: AddTaskRoute.page, path: "/addTaskRoute"),
      ];
}
