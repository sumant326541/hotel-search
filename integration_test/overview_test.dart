import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/integration_test_keys.dart';
import 'package:patrol/patrol.dart';
import 'util/setup.dart';

void main() {
  patrolTest('Overview: Hotel Booking title displayed on overview screen',
      framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
      ($) async {
    await $.pumpWidgetAndSettle(await buildApp());
    // Check if the overview page is displayed
    expect(find.text('Overview'), findsOneWidget);
    await $(DashboardPageKeys.hotelsPageNavigationIcon).tap();
    await $(DashboardPageKeys.favoritesPageNavigationIcon).tap();
    await $(DashboardPageKeys.accountPageNavigationIcon).tap();
    await Future.delayed(const Duration(seconds: 10));
  });
}
