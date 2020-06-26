import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class VtopPage extends StatefulWidget {
  @override
  _VtopPageState createState() => _VtopPageState();
}

class _VtopPageState extends State<VtopPage> {
  @override
  Widget build(BuildContext context) {
    final firstTabColor = Color(0xFF1d1d1d);
    return Scaffold(
      appBar: AppBar(
        title: Text("GOOGLE"),
        centerTitle: true,
        backgroundColor: firstTabColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: WebView(
          initialUrl: "https://www.google.com",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}