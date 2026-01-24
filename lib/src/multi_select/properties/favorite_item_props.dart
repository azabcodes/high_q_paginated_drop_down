import 'package:flutter/material.dart';
import '../../../high_q_paginated_drop_down.dart';

class FavoriteItemProps<T> {
  final bool showFavoriteItems;

  final FavoriteItemsBuilder<T>? favoriteItemBuilder;

  final FavoriteItems<T>? favoriteItems;

  final MainAxisAlignment favoriteItemsAlignment;

  const FavoriteItemProps({
    this.favoriteItemBuilder,
    this.favoriteItems,
    this.favoriteItemsAlignment = MainAxisAlignment.start,
    this.showFavoriteItems = false,
  });
}
