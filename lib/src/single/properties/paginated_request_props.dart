import '../../../high_q_paginated_drop_down.dart';

class PaginatedRequestProps<T> {
  final Future<List<MenuItemModel<T>>?> Function(
    int page,
    String? searchText,
  )?
  paginatedRequest;
  final int? requestItemCount;

  const PaginatedRequestProps({
    this.paginatedRequest,
    this.requestItemCount,
  });
}
