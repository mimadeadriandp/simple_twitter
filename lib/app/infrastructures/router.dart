import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_twitter/app/ui/pages/home/view.dart';
import 'package:simple_twitter/app/ui/pages/login/view.dart';
import 'package:simple_twitter/app/ui/pages/pages.dart';

class Router {
  RouteObserver<PageRoute> routeObserver;

  Router() {
    routeObserver = RouteObserver<PageRoute>();
  }

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.login:
        return _buildRoute(settings, new LoginPage());
      case Pages.home:
        return _buildRoute(settings, new HomePage());
      default:
        return null;
    }
  }

  PageRouteBuilder _buildRoute(RouteSettings settings, Widget builder) {
    return new PageRouteBuilder(
      settings: settings,
      // builder: (ctx) => builder,
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          builder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
