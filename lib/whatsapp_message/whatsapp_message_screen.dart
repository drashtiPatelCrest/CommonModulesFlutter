import 'package:flutter/material.dart';
import 'package:modules_flutter/base_classes/base_button.dart';
import 'package:modules_flutter/base_classes/base_textField.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppMessageScreen extends StatefulWidget {
  final String title;

  const WhatsAppMessageScreen({Key? key, required this.title})
      : super(key: key);

  @override
  State<WhatsAppMessageScreen> createState() => _WhatsAppMessageScreenState();
}

class _WhatsAppMessageScreenState extends State<WhatsAppMessageScreen> {
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();
  String? _whatsappUrlAndroid;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    /*_whatsappUrlAndroid =
        "${"whatsapp://send?phone=+91${_controllerPhoneNumber.text}"}&text=${_controllerMessage.text}";*/
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

extension on _WhatsAppMessageScreenState {
  //Main body view
  Widget _mainView() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //Title
            const Text("Send WhatsApp Message",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            //Phone Number
            BaseTextField(
              context,
              controller: _controllerPhoneNumber,
              hintText: "Enter Phone Number",
              labelText: "Phone Number",
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validatorFun: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }
              },
            ),
            const SizedBox(height: 20),
            //Message
            BaseTextField(
              context,
              controller: _controllerMessage,
              hintText: "Enter Message",
              labelText: "Message",
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              validatorFun: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter message';
                }
              },
            ),
            const SizedBox(height: 40),
            //Send
            BaseMaterialButton("Send Message", () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _whatsappUrlAndroid =
                      "${"whatsapp://send?phone=+91${_controllerPhoneNumber.text}"}&text=${_controllerMessage.text}";
                });
                debugPrint("URL => $_whatsappUrlAndroid");

                if (await canLaunchUrl(Uri.parse(_whatsappUrlAndroid!))) {
                  await launchUrl(Uri.parse(_whatsappUrlAndroid!));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Whatsapp is not installed")));
                }
              }
            })
          ],
        ),
      ),
    );
  }
}
