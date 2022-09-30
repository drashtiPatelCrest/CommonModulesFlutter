import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modules_flutter/deep_linking/path_constant.dart';
import 'package:modules_flutter/utils/alert_dialog_util.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkScreen extends StatefulWidget {
  final String title;

  const DeepLinkScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<DeepLinkScreen> createState() => _DeepLinkScreenState();
}

class _DeepLinkScreenState extends State<DeepLinkScreen> {
  String _linkMessage = "";
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();

    initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: true,
          centerTitle: true),
      body: _mainView(),
    );
  }
}

extension on _DeepLinkScreenState {
  //Main body view
  Widget _mainView() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          customAlertButton(context, "Open Amazon",
              verticalPadding: 16.0, fontSize: 16.0, isClose: false, onTap: () {
            _createDynamicLink(true, kProductLink)
                /*!_isCreatingLink
                ? () => _createDynamicLink(true, kImageCropLink)
                : null*/
                ;
          }),
          const SizedBox(
            height: 20.0,
          ),
          InkWell(
              onTap: () async {
                if (_linkMessage.isNotEmpty) {
                  await launchUrl(Uri.parse(_linkMessage),
                      mode: LaunchMode.externalNonBrowserApplication);
                }
              },
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: _linkMessage));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied Link!')),
                );
              },
              child: Text(
                _linkMessage,
              ))
        ],
      ),
    );
  }
}

extension on _DeepLinkScreenState {
  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      /*if (queryParams.isNotEmpty) {
        String? productId = queryParams["id"];
        Navigator.pushNamed(context, dynamicLinkData.link.path,
            arguments: {"productId": int.parse(productId!)});
      } else {*/

      debugPrint("Dynamic Url => ${dynamicLinkData.link.path}");

      /*Navigator.pushNamed(
        context,
        dynamicLinkData.link.path,
      );*/
      // }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> _createDynamicLink(bool short, String link) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: kUriPrefix,
      link: Uri.parse(kUriPrefix + link),
      androidParameters: const AndroidParameters(
        packageName: 'com.demo.modules_flutter',
        minimumVersion: 0,
      ),
    );

    Uri? url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      log("Message => $_linkMessage");
      _isCreatingLink = false;
    });
  }
}
