import 'package:flutter/material.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';

class NewAuthScreen extends StatefulWidget {
  final String title;

  const NewAuthScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<NewAuthScreen> createState() => _NewAuthScreenState();
}

class _NewAuthScreenState extends State<NewAuthScreen> {
  String _publicKey = 'Not retrieved/Not set';
  String _signature = 'Unknown';
  String _payload = 'Zmx1dHRlcl9iaW9tZXRyaWNz';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_biometrics'),
          backgroundColor: Colors.blueGrey,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              alignment: Alignment.center,
              child: Text(
                "1. Generate a key pair",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20.0),
              child: MaterialButton(
                onPressed: createKeys,
                child: Text("Create keys"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Public key: $_publicKey",
                style: TextStyle(color: Colors.white),
              ),
              margin: EdgeInsets.only(top: 10.0),
              color: Colors.blueGrey,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
              alignment: Alignment.center,
              child: Text(
                "2. Provide a payload to sign",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Payload to sign (Base64 encoded)',
                  hintText: 'Zmx1dHRlcl9iaW9tZXRyaWNz',
                ),
                onChanged: (value) {
                  setState(() {
                    _payload = value;
                  });
                },
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: sign,
                child: Text("Sign '$_payload'"),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Signature: $_signature",
                style: TextStyle(color: Colors.white),
              ),
              margin: EdgeInsets.only(top: 10.0),
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}

extension on _NewAuthScreenState {
  Future<void> createKeys() async {
    var biometrics = FlutterBiometrics();
    String publicKey = await biometrics.createKeys(
        reason: 'Please authenticate to create public/private key pair');

    setState(() {
      _publicKey = publicKey;
      debugPrint("Public Key => $_publicKey");
      debugPrint("Payload => $_payload");
    });

    if (!mounted) return;
  }

  Future<void> sign() async {
    var biometrics = FlutterBiometrics();
    String signature = await biometrics.sign(
        payload: _payload,
        reason: 'Please authenticate to sign specified payload');

    setState(() {
      _signature = signature;
      debugPrint("Signature => $_signature");
    });

    if (!mounted) return;
  }
}
