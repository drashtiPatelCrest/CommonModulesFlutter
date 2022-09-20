import 'package:flutter/material.dart';
import 'package:modules_flutter/biometrics_auth/remote_auth_biometrics.dart';
import 'package:modules_flutter/image_crop/image_crop_screen.dart';
import 'package:modules_flutter/utils/alert_dialog_util.dart';
import 'package:modules_flutter/utils/functions_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modules')),
      body: _mainView(),
    );
  }
}

extension on _DashboardScreenState {
  Widget _mainView() {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            customAlertButton(context, "Biometrics Authentication",
                verticalPadding: 16.0,
                fontSize: 16.0,
                isClose: false, onTap: () {
              navigateToNextScreen(
                  context, const RemoteAuthBiometrics(title: "Authentication"));
            }),
            const SizedBox(height: 10),
            customAlertButton(context, "Image Cropping",
                verticalPadding: 16.0,
                fontSize: 16.0,
                isClose: false, onTap: () {
              navigateToNextScreen(
                  context, const ImageCropScreen(title: "Image Crop"));
            }),
            const SizedBox(height: 10),
          ],
        ));
  }
}
