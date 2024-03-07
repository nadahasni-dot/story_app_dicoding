import 'package:go_router/go_router.dart';

import '../modules/splash/splash_screen.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: SplashScreen.path,
      name: SplashScreen.path,
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
