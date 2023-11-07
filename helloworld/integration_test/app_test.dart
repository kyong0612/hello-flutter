import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:helloworld/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // groupによってテストをグループ化することができる
  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter.',
        (tester) async {
      app.main();

      // 描画が終わるまで待つ
      await tester.pumpAndSettle();

      // 0が書かれているwidgetが1つあることを確認
      expect(find.text('0'), findsOneWidget);

      // Incrementをタップする
      final Finder fab = find.byTooltip('Increment');
      await tester.tap(fab);

      // 描画が終わるまで待つ
      await tester.pumpAndSettle();

      // 1が書かれているwidgetが1つあることを確認
      expect(find.text('1'), findsOneWidget);
    });
  });
}
