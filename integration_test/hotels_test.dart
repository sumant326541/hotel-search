import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/integration_test_keys.dart';
import 'package:patrol/patrol.dart';
import 'util/setup.dart';

void main() {
  patrolTest(
    'Search for hotels and mark them as favorites',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    ($) async {
      await $.pumpWidgetAndSettle(await buildApp());
      // verify the page title
      expect(find.text('Hotel Booking'), findsOneWidget);

      // Navigate to Hotels page
      await $(DashboardPageKeys.hotelsPageNavigationIcon).tap();

      // Enter a search query
      await $(HotelsPageKeys.hotelsSearchTextField).enterText('berlin');
      await $.pumpAndSettle();

      // Wait for hotels to load
      await $(HotelsPageKeys.hotelCardFavoriteButton)
          .waitUntilVisible(timeout: const Duration(seconds: 10));

      // Verify that at least one hotel card is displayed
      final favoriteButtons =
          find.byKey(HotelsPageKeys.hotelCardFavoriteButton);
      final favoriteCount = favoriteButtons.evaluate().length;
      expect(favoriteCount, greaterThan(0),
          reason: 'Expected at least one favorite button');

      // make all displayed hotels as favorites
      for (int i = 0; i < favoriteCount; i++) {
        // Tap to favorite
        await $(HotelsPageKeys.hotelCardFavoriteButton).at(i).tap();
        await $.pump();

        // Check that filled icon is visible
        expect(
          $(HotelsPageKeys.hotelCardFavoriteSelectedIcon)
              .at(i)
              .evaluate()
              .isNotEmpty,
          isTrue,
          reason: 'Item $i should show filled favorite icon',
        );
      }
    },
  );
}
