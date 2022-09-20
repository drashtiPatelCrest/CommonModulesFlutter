import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';

class RemoteAuthBiometrics extends StatefulWidget {
  const RemoteAuthBiometrics({Key? key}) : super(key: key);

  @override
  State<RemoteAuthBiometrics> createState() => _RemoteAuthBiometricsState();
}

class _RemoteAuthBiometricsState extends State<RemoteAuthBiometrics> {
  //String _publicKey = 'Not retrieved/Not set';
  String? _publicKey;
  String _signature = 'Unknown';
  String _payload = 'Zmx1dHRlcl9iaW9tZXRyaWNz';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text(
          'Authentication',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: [
            //Fingerprint icon
            const Icon(
              Icons.fingerprint,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(
              height: 40.0,
            ),
            //Login with touch Id
            const Text(
              "Login With Touch Id / Face Id",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 40.0,
            ),
            //Authentication using touch Id & face Id
            MaterialButton(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Text(
                    "Authenticate Using Biometrics",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 18.0),
                  ),
                ),
                onPressed: () {
                  _createKeys();
                })
          ],
        ),
      ),
    );
  }
}

extension on _RemoteAuthBiometricsState {
  //Auth to create public/private keys
  Future<void> _createKeys() async {
    try {
      var biometrics = FlutterBiometrics();
      String publicKey = await biometrics.createKeys(
          reason:
              'Scan your fingerprint to authenticate' /*reason: 'Please authenticate to create public/private key pair'*/);

      setState(() {
        _publicKey = publicKey;
        log("Public Key => ${_publicKey?.trim()}");

        if (_publicKey!.isNotEmpty) {
          showSnackBar("Successfully Authenticated");
        } else {
          showSnackBar("Authentication Failed");
        }

        //_payload = "${DateTime.now().millisecondsSinceEpoch}some message";
        log("Payload => ${_payload.trim()}");
      });

      _sign();
    } on PlatformException catch (e) {
      log(e.toString());
      showSnackBar("Authentication Failed");
      return;
    } catch (e) {
      log(e.toString());
      showSnackBar("Authentication Failed");
      return;
    }

    if (!mounted) return;
  }

  //Auth to create signature
  Future<void> _sign() async {
    var biometrics = FlutterBiometrics();
    String signature = await biometrics.sign(
        payload: _payload,
        reason: 'Please authenticate to sign specified payload');

    setState(() {
      _signature = signature;
      log("Signature => ${_signature.trim()}");
    });

    if (!mounted) return;
  }

  //SnackBar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
