import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class UniLinkScreen extends StatefulWidget {
  final String title;

  const UniLinkScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<UniLinkScreen> createState() => _UniLinkScreenState();
}

class _UniLinkScreenState extends State<UniLinkScreen> {
  String? link;

  @override
  void initState() {
    super.initState();

    /*initUniLinks().then((value) => setState(() {
          link = value;
          debugPrint("URL => $link");
        }));*/
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

extension on _UniLinkScreenState {
  Widget _mainView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            textColor: Colors.white,
            color: Colors.deepPurple,
            onPressed: () async {
              // await launchUrl(Uri.parse("https://www.amazon.com/dp/B09P1PDWGY?linkCode=ll1&tag=amacash0e-20"),
              await launchUrl(
                  /*Uri.parse(
                    "https://www.amazon.ae/Sterilizer-Aromatherapy-Multifunctional-Ultraviolet-Disinfection/dp/B08888YPRJ/ref=sr_1_1?crid=1SN8WO8046U79&keywords=mobile&qid=1664442777&qu=eyJxc2MiOiI4LjkwIiwicXNhIjoiNy41MCIsInFzcCI6IjYuMTkifQ%3D%3D&sprefix=mobile%2Cspecialty-aps%2C192&sr=8-1&srs=16451864031"),*/
                  Uri.parse(
                      "https://www.amazon.in/Generic-Miaya-Large-Plant-Holder/dp/B08MV147LX/?_encoding=UTF8&pd_rd_w=8aRUS&content-id=amzn1.sym.782316c3-978e-4f39-a00d-7d5fcb684739&pf_rd_p=782316c3-978e-4f39-a00d-7d5fcb684739&pf_rd_r=421PH2PXEZQBNRNKVX19&pd_rd_wg=nK5hv&pd_rd_r=33b9c4ee-b670-4139-90b8-531f0ef13c76&ref_=pd_gw_unk"),
                  /*Uri.parse(
                    "https://www.amazon.com/Keyboard-Android-Quad-Core-Bluetooth-Tablets/dp/B0B6P61Y47/ref=sr_1_3_sspa?fst=as%3Aoff&pd_rd_r=42317990-72db-41a4-87ef-3cc6e3adad79&pd_rd_w=D59dQ&pd_rd_wg=Sluep&pf_rd_p=5b7fc375-ab40-4cc0-8c62-01d4de8b648d&pf_rd_r=T1YBT5ZZ82A9R8EJESCH&qid=1664441855&rnid=16225007011&s=computers-intl-ship&sr=1-3-spons&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExNE1GR1M3WEVZWUE1JmVuY3J5cHRlZElkPUEwMjIwODA4MllLMkEwNExDUUZHSSZlbmNyeXB0ZWRBZElkPUEwOTkzNzUyM0xVODRZT1JYTDMzViZ3aWRnZXROYW1lPXNwX2F0Zl9icm93c2UmYWN0aW9uPWNsaWNrUmVkaXJlY3QmZG9Ob3RMb2dDbGljaz10cnVl&th=1"),*/
                  /*Uri.parse(
                    "https://www.amazon.com/dp/B09P1PDWGY?linkCode=ll1&tag=amacash0e-20"),*/
                  mode: LaunchMode.externalApplication);
            },
            child: const Text("amazon.in link"),
          ),
          const SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            textColor: Colors.white,
            color: Colors.deepPurple,
            onPressed: () async {
              await launchUrl(
                  Uri.parse(
                      "https://www.amazon.com/Keyboard-Android-Quad-Core-Bluetooth-Tablets/dp/B0B6P61Y47/ref=sr_1_3_sspa?fst=as%3Aoff&pd_rd_r=42317990-72db-41a4-87ef-3cc6e3adad79&pd_rd_w=D59dQ&pd_rd_wg=Sluep&pf_rd_p=5b7fc375-ab40-4cc0-8c62-01d4de8b648d&pf_rd_r=T1YBT5ZZ82A9R8EJESCH&qid=1664441855&rnid=16225007011&s=computers-intl-ship&sr=1-3-spons&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExNE1GR1M3WEVZWUE1JmVuY3J5cHRlZElkPUEwMjIwODA4MllLMkEwNExDUUZHSSZlbmNyeXB0ZWRBZElkPUEwOTkzNzUyM0xVODRZT1JYTDMzViZ3aWRnZXROYW1lPXNwX2F0Zl9icm93c2UmYWN0aW9uPWNsaWNrUmVkaXJlY3QmZG9Ob3RMb2dDbGljaz10cnVl&th=1"),
                  /*Uri.parse(
                        "https://www.amazon.com/dp/B09P1PDWGY?linkCode=ll1&tag=amacash0e-20"),*/
                  mode: LaunchMode.externalApplication);
            },
            child: const Text("amazon.com link"),
          ),
          const SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            textColor: Colors.white,
            color: Colors.deepPurple,
            onPressed: () async {
              await launchUrl(
                  Uri.parse(
                      "https://www.amazon.com/dp/B09P1PDWGY?linkCode=ll1&tag=amacash0e-20"),
                  mode: LaunchMode.externalApplication);
            },
            child: const Text("Amacash link"),
          ),
        ],
      ),
    );
  }

  Future<String?> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      debugPrint("URL Get ............");

      final initialLink = await getInitialLink();
      debugPrint("URL Get => $initialLink");
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      return initialLink;
    } catch (e) {
      debugPrint("URL Error => $e");
      // Handle exception by warning the user their action did not succeed
      // return?
      return null;
    }
  }
}
