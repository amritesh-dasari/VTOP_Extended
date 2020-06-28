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
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: WebView(
          initialUrl: "http://vtop2.vitap.ac.in:8070/vtop/initialProcess",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
