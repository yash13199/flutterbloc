
  import 'package:flutterbloc/src/screen/AuthScreen/authScreen.dart';
import 'package:flutterbloc/src/screen/HomeScreen/homeUI.dart';
import 'package:flutterbloc/src/screen/splashScreen/splashscreen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
    GoRoute(path: '/' , builder: (context, state) => const SplashScreen(),),
    GoRoute(path: '/home', builder: (context, state) => const HomePageUI(),),
    GoRoute(path: '/auth', builder: (context, state) => const Authscreen(),)

  ]
    
  );