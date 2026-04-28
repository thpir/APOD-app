import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ArSolarScreen extends StatelessWidget {
  static const routeName = '/ar_solar';

  const ArSolarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AR Solar System',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('https://thpir.github.io/portfolio/ar-solar-system/'),
        ),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          iframeAllow:
              'camera; microphone; geolocation; gyroscope; accelerometer',
          iframeAllowFullscreen: true,
          javaScriptEnabled: true,
        ),
        onPermissionRequest: (controller, request) async {
          return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT,
          );
        },
      ),
    );
  }
}
