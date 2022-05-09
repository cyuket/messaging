import 'package:flutter/material.dart';
import 'package:messaging/core/navigators/routes.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/auth/presentation/pages/login.dart';
import 'package:messaging/feature/auth/presentation/pages/signup.dart';
import 'package:messaging/feature/chat/presentation/pages/chat_screen.dart';
import 'package:messaging/feature/chat/presentation/pages/home_container.dart';

/// Generate routes for navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.loginPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const LoginPage(),
      );
    case Routes.signupPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SignupPage(),
      );
    case Routes.chatScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChatScreen(
          user: settings.arguments as UserModel,
        ),
      );
    case Routes.home:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeContainer(
          params: settings.arguments as HomeContainerParams?,
        ),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute<dynamic>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
