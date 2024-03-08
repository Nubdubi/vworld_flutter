import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class VworldMapFlutter extends StatefulWidget {
  VworldMapFlutter({super.key, required this.apiKey});
  final String apiKey;
  @override
  State<VworldMapFlutter> createState() => _VworldMapFlutterState();
}

class _VworldMapFlutterState extends State<VworldMapFlutter> {
  // late String fileText;
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  late String apikey;
  late String header;
  @override
  void initState() {
    super.initState();
    apikey = widget.apiKey; // initState 내에서 초기화
    header = '''<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript" src="https://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=$apikey"></script>
<head>''';
    _onLoadHtmlStringExample();
  }

  String kLocalExamplePage = '''


<script>vw.MapControllerOption = {
   container : "vmap",
   mapMode : "2d-map",
   basemapType : vw.ol3.BasemapType.GRAPHIC,
   controlDensity : vw.ol3.DensityType.EMPTY,
   interactionDensity : vw.ol3.DensityType.BASIC,
   controlsAutoArrange : true,
   homePosition : vw.ol3.CameraPosition,
   initPosition : vw.ol3.CameraPosition,
  };
   
  mapController = new vw.MapController(vw.MapControllerOption);</script>
</head>
<body>
 <div id="vmap" style="width:100%;height:100%;left:0px;top:0px"></div>
  <select id="setMode" onchange="mapController.setMode(this.value)">
   <option value="2d-map">2d-map</option>
   <option value="3d-map">3d-map</option>
 </select>
 
''';

  final end = '''<script type="text/javascript">
  vw.MapControllerOption = {
   container : "vmap",
   mapMode : "2d-map",
   basemapType : vw.ol3.BasemapType.GRAPHIC,
   controlDensity : vw.ol3.DensityType.EMPTY,
   interactionDensity : vw.ol3.DensityType.BASIC,
   controlsAutoArrange : true,
   homePosition : vw.ol3.CameraPosition,
   initPosition : vw.ol3.CameraPosition,
  };
  
  mapController = new vw.MapController(vw.MapControllerOption);
  
 </script>

</body>
</html>''';

  Future<void> _onLoadHtmlStringExample() {
    return webViewController.loadHtmlString(header + kLocalExamplePage + end);
  }
  // Future<void> loadHtmlFile() async {
  //   fileText = await rootBundle.loadString('assets/vworld_map.html');
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: WebViewWidget(
      controller: webViewController,
    ));
  }
}
