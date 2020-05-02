import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.isInitialRoute) {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.isInitialRoute) {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );

    // return SlideTransition(
    //   position: new Tween<Offset>(
    //     begin: const Offset(-1.0, -1.0),
    //     end: Offset.zero,
    //   ).animate(animation),
    //   child: new SlideTransition(
    //     position: new Tween<Offset>(
    //       begin: Offset.zero,
    //       end: const Offset(1.0, 0.0),
    //     ).animate(secondaryAnimation),
    //     child: child,
    //   ),
    // );
  }
}
