import 'package:flutter/material.dart';
import 'package:preschool_app/screens/activity/activity_List.dart';
import 'package:preschool_app/screens/activity/games/game_page.dart';
import 'package:preschool_app/screens/home/home.dart';
import 'package:preschool_app/screens/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ActivityList(uid: args,));
        break;
      case '/Games':
        return MaterialPageRoute(builder: (_) => Games(),);
        break;
      case '/Home':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => Home(args),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
        break;
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return  MaterialPageRoute(builder: (_) => Wrapper());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}