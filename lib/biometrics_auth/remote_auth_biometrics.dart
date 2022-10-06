import 'dart:developer';

import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';

class RemoteAuthBiometrics extends StatefulWidget {
  final String title;

  const RemoteAuthBiometrics({Key? key, required this.title}) : super(key: key);

  @override
  State<RemoteAuthBiometrics> createState() => _RemoteAuthBiometricsState();
}

class _RemoteAuthBiometricsState extends State<RemoteAuthBiometrics> {
  //String _publicKey = 'Not retrieved/Not set';
  String? _publicKey;
  String _signature = 'Unknown';
  String _payload = 'Zmx1dHRlcl9iaW9tZXRyaWNz';
  final _biometrics = FlutterBiometrics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
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
                }),
            /*const SizedBox(
              height: 40.0,
            ),
            //Verify Authentication
            MaterialButton(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Text(
                    "Verify Authentication",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 18.0),
                  ),
                ),
                onPressed: () {
                  _verifySignature();
                })*/
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
      //var biometrics = FlutterBiometrics();
      String publicKey = await _biometrics.createKeys(
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

        _payload = "${DateTime.now().millisecondsSinceEpoch}some message";
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
    //var biometrics = FlutterBiometrics();
    String signature = await _biometrics.sign(
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

  //Verify authentication
  void _verifySignature() async {
    setState(() {
      /*_signature =
          "a74cks00CmqKyZEmWMyR11yqJZswtE0yCsct3kpfdSyoqFAVQGTF0iNWZa6btlPKIL4c5dDSY6w5GSF+z73aXwANXs+3SDoMC6qckFU4n/EJgRg5wzy8FpoHOwkDxCEZFRU2s5NEUuIwB71MwV1tTP03lG0SjORYYAGNDGeDBhwIXppc3LqCB5QZafvFhRDJSRtl6kM97q/hgXUXsY66yC1Jola/B96fNQQCGVr7CrU7bouNAfGlayEzt5QRwxDKGhPx5UKnhkqdLsoo6kRZ13GyDouXC76obJIYEyeFq5XtNUAIT/ErhzpSuYMPIYklSdv7My73nkA2dDogKZMcAg==";
      _payload = "1664786546049some message";
      _publicKey =
          "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2JaltANEndbIoLKzQx7c+Y7kyTNXRJTW8z2QvuqVV9tisL6NjWX9csA6mw3Hs//fnO1RIvY3owQvxtyrtR06cOk8yUr/uLGliaUcZYXQZUwIWZR4XaqwoRjqvtC1nXufnnaxbV9ebi3TvfRLWcJYSbefciZPq/YU2iileBVhye54y4VJxMAnPhaGPNv8OujJsq0xiTmCDIOZUDCQNsn9AChU/MZ4Pkk764vsaO1DK5it3My+ZuTrSePW873AwpZ+rhVOZ+7MA8s8vlirKCU7lU3PyZri4dbo4UYDGA/JSBpPtpoTFsmXY4x8AZmD/4loyym0yvNd/0pJhbHHkeBZEQIDAQAB";*/

      _signature =
          "hSoEFtGM0JgpsMp6Nf7jUOQjNJkhY/vjU+lGis+I6tcSFSxByRXFoT/90NGf885iCyOLJmtmKYbOssNPNFkSz0Ymyu4nQZvK3knXmhH4NsAelh8384AOuSTYJbUCucLyx+ZBOuKA7CncI9qLDKE507u2q5iIB9yAZRPSO4aSYgKd6OgywTgBelbouaLti3A3Rqr7MvWl33tzd5h42DgE5NmfKdWowtZZ4kDk3U1W6umOHUSntUB/2uZIpkOmGiNVFXt1I7mjCfXlgvCYBJYznrm2KquyWC+xtDWlwJuV5+FHGVPaP2LAyDE36O1EMok24tkxpa2VwGjyxQtfJl0bgQ==";
      _payload = "1663247196some message";
      _publicKey =
          "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArfcOeA+tZAoI00jbOr7oi52mjfMrHsEFy5XKTjdEq2FZ8Q/aVuPZvjZVV1inExzBEqBU4Zy6fkxV0y6bY6LSHttigkhdt8qPJdGy+UBlxCkf8ahwuiL2g3nMxtSiepahx5Q8rZ8JF72q5WMIDsfsuWGJmQPdoOxNgEBxLdQqEgEvqj2mZneq1n00xiBl9VgZfXSV9UyWI4KSTbsECgpZvP6TnJEOKunl0IvpxoTtW1aa8nPFLjLiisW5x1/IHqwAmIVS0m4+7Dr9IZh+n2h177ofpNucXFAyCp/V5GgdYsN0dSgTbskDp1AyqLguJWemBVAnCIBU2mKJKEb+V83ifQIDAQAB";
    });

    /*debugPrint(
        "Public Key => $_publicKey \n Payload => $_payload \n Signature => $_signature");*/

    try {
      var result = await RSA.verifyPKCS1v15(
        _signature, _payload, Hash.SHA256, _publicKey!);

      //var result = await RSA.verifyPKCS1v15("", "", Hash.SHA256, "");
      debugPrint("Verification Result => $result");
    } catch (e) {
      debugPrint("Verification Error => ${(e as RSAException).cause}");
    }
  }
}
