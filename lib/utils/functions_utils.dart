import 'package:flutter/material.dart';

void navigateToNextScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
