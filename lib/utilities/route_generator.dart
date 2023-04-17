import 'package:alert_up_user/screens/initialize.dart';
import 'package:alert_up_user/screens/user/geofence.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments != null ? settings.arguments as Map : null;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Initialize());

      case '/user':
        return MaterialPageRoute(builder: (_) => GeoFence());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: const Text('Something wrong in here')));
    });
  }
}
