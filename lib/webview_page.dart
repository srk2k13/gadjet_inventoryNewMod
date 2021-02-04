import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => WebviewPage(),

          //home: MyHomePage(),
        });
  }

}


class WebviewPage extends StatefulWidget {
  @override

  var downloadedUrl;
  WebviewPage({this.downloadedUrl});
  @override
  WebviewPageState createState() => WebviewPageState();
}

class WebviewPageState extends State<WebviewPage> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:WebView(
            initialUrl: widget.downloadedUrl,
            javascriptMode: JavascriptMode.unrestricted,
          )
      ),
    );
  }
}