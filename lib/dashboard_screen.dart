import 'package:flutter/material.dart';
import 'package:modules_flutter/biometrics_auth/new_auth_screen.dart';
import 'package:modules_flutter/biometrics_auth/remote_auth_biometrics.dart';
import 'package:modules_flutter/deep_linking/deep_link_screen.dart';
import 'package:modules_flutter/deep_linking/uni_link_screen.dart';
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
            //Biometrics Authentication
            customAlertButton(context, "Biometrics Authentication",
                verticalPadding: 16.0,
                fontSize: 16.0,
                isClose: false, onTap: () {
              navigateToNextScreen(
                  context, const NewAuthScreen(title: "Authentication"));
            }),
            const SizedBox(height: 10),
            //Image Cropper
            customAlertButton(context, "Image Cropper",
                verticalPadding: 16.0,
                fontSize: 16.0,
                isClose: false, onTap: () {
              navigateToNextScreen(
                  context, const ImageCropScreen(title: "Crop Image"));
            }),
            const SizedBox(height: 10),
            //Deep Linking
            customAlertButton(context, "Deep Linking",
                verticalPadding: 16.0,
                fontSize: 16.0,
                isClose: false, onTap: () {
              navigateToNextScreen(
                  context, const UniLinkScreen(title: "Deep Linking"));
            }),
            const SizedBox(height: 10),
            //Send WhatsApp Message
            customAlertButton(context, "Send WhatsApp Message",
                verticalPadding: 16.0,
                fontSize: 16.0,
                isClose: false, onTap: () {
                  navigateToNextScreen(
                      context, const UniLinkScreen(title: "Deep Linking"));
                }),
            const SizedBox(height: 10),
          ],
        ));
  }
}
