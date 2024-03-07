import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VworldMapFlutter(),
    );
  }
}

class VworldMapFlutter extends StatefulWidget {
  const VworldMapFlutter({super.key});

  @override
  State<VworldMapFlutter> createState() => _VworldMapFlutterState();
}

class _VworldMapFlutterState extends State<VworldMapFlutter> {
  late String fileText;
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  void initState() {
    super.initState();
    loadHtmlFile();
  }

  Future<void> loadHtmlFile() async {
    fileText = await rootBundle.loadString('assets/vworld_map.html');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = 'B2940A18-EA69-3C09-A28F-37613BC53FED';
    final modifiedFileText = fileText.replaceAll('{API_KEY}', apiKey);

    return Scaffold(
      appBar: AppBar(
        title: Text('VWorld Map Example'),
      ),
      body: modifiedFileText.isNotEmpty
          ? WebViewWidget(
              controller: WebViewController(),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
