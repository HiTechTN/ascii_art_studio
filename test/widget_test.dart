import 'package:flutter_test/flutter_test.dart';

import 'package:ascii_art_studio/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const AsciiArtStudioApp());

    expect(find.text('Image to ASCII'), findsOneWidget);
    expect(find.text('Text to ASCII'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);
  });
}