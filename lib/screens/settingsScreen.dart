import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishworks_flutter_app/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var button1Color = const Color(0xff002633).obs;
  var button1TextColor = const Color(0xffFFAD33).obs;
  var button2Color = const Color(0xffffffff).obs;
  var button2TextColor = const Color(0xff002633).obs;
  var url = 'https://krishworks.com/gallery/';
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: const Color(0xff002633),
          title: const Text(
            "Setting",
            style: TextStyle(color: Colors.white),
          ),
          leading: Center(
              child: TextButton(
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          )),
        ),
        body: Row(
          children: [
            Column(children: [
              Obx(() => Container(
                  width: 140,
                  color: button1Color.value,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        button1Color.value = const Color(0xff002633);
                        button1TextColor.value = const Color(0xffFFAD33);
                        button2Color.value = const Color(0xffffffff);
                        button2TextColor.value = const Color(0xff002633);
                        url = 'https://krishworks.com/gallery/';
                        controller.loadUrl(url);
                      },
                      child: Text("Gallery",
                          style: TextStyle(color: button1TextColor.value))))),
              Obx(() => Container(
                    color: button2Color.value,
                    width: 140,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          button2Color.value = const Color(0xff002633);
                          button2TextColor.value = const Color(0xffFFAD33);
                          button1Color.value = const Color(0xffffffff);
                          button1TextColor.value = const Color(0xff002633);
                          url = 'https://krishworks.com/contact';
                          controller.loadUrl(url);
                        },
                        child: Text(
                          "Contact us",
                          style: TextStyle(color: button2TextColor.value),
                        )),
                  )),
              Container(
                // padding: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 2.0,
                width: 140,
                color: Colors.black,
              )
            ]),
            Flexible(
                child: WebView(
                    initialUrl: url,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller = webViewController;
                    }))
          ],
        ));
  }
}
