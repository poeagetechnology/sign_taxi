import 'package:flutter/material.dart';

/// A page route that slides the new page from the right.
/// Used for smooth, professional navigation between screens.
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            // Slide from right (Offset(1.0, 0.0)) to normal (Offset.zero)
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 350), // smooth speed
        );
}

/// Optional: You can also define a fade transition, scale transition, etc.
/// But this one slide transition is enough for the whole app.