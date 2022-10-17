import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class SecureScreen extends StatefulWidget {
  final String title;

  const SecureScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<SecureScreen> createState() => _SecureScreenState();
}

class _SecureScreenState extends State<SecureScreen> {
  bool _secureMode = false;

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

extension on _SecureScreenState {
  Widget _mainView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Secure Mode: ${_secureMode.toString()}\n'),
          ElevatedButton(
              onPressed: () async {
                final secureModeToggle = !_secureMode;

                if (secureModeToggle == true) {
                  await FlutterWindowManager.addFlags(
                      FlutterWindowManager.FLAG_SECURE);
                } else {
                  await FlutterWindowManager.clearFlags(
                      FlutterWindowManager.FLAG_SECURE);
                }

                setState(() {
                  _secureMode = !_secureMode;
                });
              },
              child: const Text("Toggle Secure Mode")),
        ],
      ),
    );
  }
}
