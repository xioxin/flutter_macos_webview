import 'package:flutter/cupertino.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  FlutterMacOSWebView? webview;
  Future<void> _onOpenPressed(PresentationStyle presentationStyle) async {
    webview = FlutterMacOSWebView(
      onOpen: () => print('Opened'),
      onClose: () => print('Closed'),
      onPageStarted: (url) {
        print('Page started: $url');
        webview?.getAllCookies();
      },
      onPageFinished: (url) {
        print('Page finished: $url');
        webview?.getAllCookies();
      },
      onWebResourceError: (err) {
        print(
          'Error: ${err.errorCode}, ${err.errorType}, ${err.domain}, ${err.description}',
        );
      },
    );

    await webview?.clearCookies();

    await webview?.getUserAgent();

    await webview?.open(
      url: 'https://flutter.dev/',
      presentationStyle: presentationStyle,
      size: Size(400.0, 400.0),
    );

    // await Future.delayed(Duration(seconds: 5));
    // await webview.close();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            child: Text('Open as modal'),
            onPressed: () => _onOpenPressed(PresentationStyle.modal),
          ),
          SizedBox(height: 16.0),
          CupertinoButton(
            child: Text('Open as sheet'),
            onPressed: () => _onOpenPressed(PresentationStyle.sheet),
          ),
        ],
      ),
    );
  }
}
