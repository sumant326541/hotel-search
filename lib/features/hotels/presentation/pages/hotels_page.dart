import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/integration_test_keys.dart';

import 'package:hotel_booking/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:hotel_booking/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:hotel_booking/features/hotels/presentation/widgets/widgets.dart';
import 'package:hotel_booking/i18n/strings.g.dart';

@RoutePage()
class HotelsPage extends StatefulWidget {
  const HotelsPage({super.key});

  @override
  State<StatefulWidget> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _onUpdateSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onUpdateSearch(String query) {
    final bloc = context.read<HotelsBloc>();
    if (query != bloc.state.params.query) {
      bloc.add(
        HotelsSearchUpdateEvent(
          params: bloc.state.params.copyWith(
            query: query,
          ),
        ),
      );
    }
  }

  int _lastItemBuilt = -1;

  void _onItemBuild(int index) {
    _lastItemBuilt = index;
    final bloc = context.read<HotelsBloc>();
    if (bloc.state.items.length < _lastItemBuilt + 5 && !bloc.state.hasError) {
      bloc.add(HotelsFetchNextPageEvent());
    }
  }

  void _retry() {
    context.read<HotelsBloc>().add(HotelsFetchNextPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: SearchTextField(
          key:HotelsPageKeys.hotelsSearchTextField,
          controller: _searchController,
          focusNode: _searchFocusNode,
        ),
      ),
      body: BlocBuilder<HotelsBloc, HotelsState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            if (state.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.hotels.error.message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    TextButton(
                      onPressed: _retry,
                      child: Text(t.hotels.error.retry),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Icon(
                  Icons.hotel_outlined,
                  size: 150,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              );
            }
          }
          return CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  _onItemBuild(index);
                  final hotel = state.items[index];
                  return BlocSelector<FavoritesBloc, FavoritesState, bool>(
                    selector: (state) => state.contains(hotel),
                    builder: (context, isFavorite) {
                      return HotelCard(
                        key: ObjectKey(hotel),
                        hotel: hotel,
                        isFavorite: isFavorite,
                        onFavoriteChanged: (selected) {
                          final bloc = context.read<FavoritesBloc>();
                          if (selected) {
                            bloc.add(AddFavoriteEvent(hotel: hotel));
                          } else {
                            bloc.add(RemoveFavoriteEvent(hotel: hotel));
                          }
                        },
                      );
                    },
                  );
                },
              ),
              if (state.loading)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              if (state.hasError)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          t.hotels.error.message,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        TextButton(
                          onPressed: _retry,
                          child: Text(t.hotels.error.retry),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
