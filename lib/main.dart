import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modules_flutter/dashboard_screen.dart';
import 'package:modules_flutter/utils/route_services.dart';
import 'package:toast/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: RouteServices.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const DashboardScreen(),
    );
  }
}
