import 'package:flutter_test/flutter_test.dart';
import 'package:daily_orbit/main.dart';

void main() {
  testWidgets('App starts on login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Entrar'), findsOneWidget);
  });
}
