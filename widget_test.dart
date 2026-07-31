import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mdy_chess/main.dart';
import 'package:mdy_chess/presentation/splash/splash_screen.dart';

void main() {
  testWidgets('App boots and shows the splash screen first',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MdyChessApp()),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('MDY'), findsOneWidget);
  });
}
