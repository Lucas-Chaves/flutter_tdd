import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    const loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);
  }

  testWidgets("Should load with correct inital State",
      (WidgetTester tester) async {
    //Arrange
    await loadPage(tester);

    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel("Email"),
      matching: find.byType(Text),
    );

    expect(
      emailTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final passwordTextChildren = find.descendant(
      of: find.bySemanticsLabel("Senha"),
      matching: find.byType(Text),
    );

    expect(
      passwordTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });
  testWidgets("Should call validate with correct values",
      (WidgetTester tester) async {
    //Arrange
    const loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);
  });
}
