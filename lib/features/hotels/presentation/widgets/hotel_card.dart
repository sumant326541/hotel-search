import 'package:flutter/material.dart';
import 'package:hotel_booking/core/integration_test_keys.dart';
import 'package:hotel_booking/features/hotels/domain/entities/entities.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    super.key,
    required this.hotel,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  final Hotel hotel;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      hotel.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (hotel.description != null)
                      Text(
                        hotel.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ),
            IconButton(
              key: HotelsPageKeys.hotelCardFavoriteButton,
              icon: Icon(
                  key: HotelsPageKeys.hotelCardFavoriteIcon,
                  Icons.favorite_outline),
              selectedIcon: Icon(
                  key: HotelsPageKeys.hotelCardFavoriteSelectedIcon,
                  Icons.favorite),
              isSelected: isFavorite,
              onPressed: () => onFavoriteChanged(!isFavorite),
            ),
          ],
        ),
      ),
    );
  }
}
