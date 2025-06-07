import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/account/presentation/pages/account_page.dart';

void main() {
  testWidgets('account page ...', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AccountPage()));
    await tester.pumpAndSettle();
    final icon = find.byType(Icon);
    expect(icon, findsOneWidget);
  });
}
