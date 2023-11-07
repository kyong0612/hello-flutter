import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mytest1', () {
    int ant = 10;
    expect(ant, 10);
  });

  test('mytest2', () {
    int ant = 10;
    expect(ant, 11);
  });

  test('mytest3', () {
    int ans = 0;
    expect(ans, 100);
  }, skip: "一旦スキップ");
}
