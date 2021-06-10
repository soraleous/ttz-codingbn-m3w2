import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../model/restaurant.dart';
import 'card.dart';

const double _minSpacingPx = 16;
const double _cardWidth = 360;

class RestaurantGrid extends StatelessWidget {
  RestaurantGrid({
    @required RestaurantPressedCallback onRestaurantPressed,
    @required List<Restaurant> restaurants,
  })  : _onRestaurantPressed = onRestaurantPressed,
        _restaurants = restaurants;

  final RestaurantPressedCallback _onRestaurantPressed;
  final List<Restaurant> _restaurants;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      // ResponsiveGridList crashes if desiredItemWidth + 2*minSpacing > Device window on Android
      desiredItemWidth: math.min(
          _cardWidth, MediaQuery.of(context).size.width - (2 * _minSpacingPx)),
      minSpacing: _minSpacingPx,
      children: _restaurants
          .map((restaurant) => RestaurantCard(
                restaurant: restaurant,
                onRestaurantPressed: _onRestaurantPressed,
              ))
          .toList(),
    );
  }
}
