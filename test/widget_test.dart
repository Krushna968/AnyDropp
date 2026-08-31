// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anydrop/main.dart';

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    FlutterError.onError = (details) {
      if (details.exceptionAsString().contains('NetworkImageLoadException')) {
        return;
      }
      FlutterError.presentError(details);
    };

    await tester.pumpWidget(const AnydropZomatoApp());
    expect(find.text('RECOMMENDED FOR YOU'), findsOneWidget);
  });
}
