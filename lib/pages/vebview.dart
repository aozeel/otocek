import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  static String url;
  WebViewPage(String url2) {
    url = url2;
  }
  @override
  VebViewState createState() => VebViewState(url);
}

class VebViewState extends State<WebViewPage> {
  String url1;
  VebViewState(this.url1);
  @override
  Widget build(BuildContext context) {
      print("Link Detay :  $url1");
    return Scaffold(
      body: Container(
        child: WebView(
          initialUrl: url1,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
