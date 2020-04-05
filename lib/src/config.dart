import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    as core;

export 'package:flutter_widget_from_html_core/src/core_config.dart';

class HtmlExtendedConfig extends core.HtmlConfig {
  /// The flag to control whether or not to apply workaround for
  /// [issue 37](https://github.com/daohoangson/flutter_widget_from_html/issues/37)
  final bool unsupportedWebViewWorkaroundForIssue37;

  /// The flag to control whether or not IFRAME is rendered as WebView.
  ///
  /// You must perform additional configuration for this to work.
  /// ### iOS
  /// Add this at the end of `ios/Runner/Info.plist` to enable
  /// Flutter's experimental platform view.
  /// See more info [here](https://pub.dev/packages/webview_flutter#ios).
  /// ```plist
  /// <key>io.flutter.embedded_views_preview</key>
  /// <string>YES</string>
  /// ```
  /// ### Android
  /// Add this into `android/app/src/main/AndroidManifest.xml`
  /// to enable internet access. Without this, you will most likely
  /// see a `net:ERR_CACHE_MISS` error for each iframe being rendered.
  /// ```xml
  /// <uses-permission android:name="android.permission.INTERNET" />
  /// ```
  final bool webView;

  /// The flag to control whether or not WebView has JavaScript enabled.
  final bool webViewJs;

  HtmlExtendedConfig({
    Uri baseUrl,
    EdgeInsets bodyPadding,
    core.NodeMetadataCollector builderCallback,
    Color hyperlinkColor,
    core.OnTapUrl onTapUrl,
    EdgeInsets tableCellPadding,
    TextStyle textStyle,
    this.unsupportedWebViewWorkaroundForIssue37,
    this.webView,
    this.webViewJs,
  }) : super(
          baseUrl: baseUrl,
          bodyPadding: bodyPadding,
          builderCallback: builderCallback,
          hyperlinkColor: hyperlinkColor,
          onTapUrl: onTapUrl,
          tableCellPadding: tableCellPadding,
          textStyle: textStyle,
        );
}