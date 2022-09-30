import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modules_flutter/image_crop/image_crop_screen.dart';

class RouteServices {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/imagecrop':
        return CupertinoPageRoute(builder: (_) {
          return const ImageCropScreen(title: "Deep Link Image Crop");
        });

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Page Not Found"),
        ),
      );
    });
  }
}
