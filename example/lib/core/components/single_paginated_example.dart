import 'package:example/core/services/api_service.dart';
import 'package:example/core/model/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';

class SinglePaginatedExample extends StatelessWidget {
  final HighQPaginatedDropdownController<AnimeDataModel> controller;

  const SinglePaginatedExample({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Single Paginated',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        FormField<AnimeDataModel>(
          validator: (value) {
            if (value == null) {
              return 'Please select an anime';
            }
            return null;
          },
          builder: (FormFieldState<AnimeDataModel> state) {
            return HighQDropDown<AnimeDataModel>.paginated(
              controller: controller,
              enabled: true,
              onChanged: (AnimeDataModel? value) {
                debugPrint('$value');
                state.didChange(value);
              },
              onDisabledTap: () {},
              requestProps: PaginatedRequestProps(
                paginatedRequest: (int page, String? searchText) async {
                  final AnimeModel? paginatedList = await getAnimeList(
                    page: page,
                    queryParameters: {
                      'page': page,
                      "q": searchText,
                    },
                  );
                  return paginatedList?.animeList?.map((e) {
                    return MenuItemModel<AnimeDataModel>(
                      value: e,
                      label: e.title ?? '',
                      child: Text(
                        e.title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList();
                },
                requestItemCount: 25,
              ),
              searchProps: const SearchProps(
                searchDelayDuration: Duration(milliseconds: 500),
                showTextField: true,
                textFieldDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type For Search ...',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              iconProps: const IconProps(
                hasTrailingClearIcon: true,
                trailingIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 24,
                ),
                trailingClearIcon: Icon(
                  Icons.clear_rounded,
                  color: Colors.redAccent,
                  size: 20,
                ),
              ),
              styleProps: StyleProps(
                width: double.infinity,
                isDialogExpanded: false,
                paddingValueWhileIsDialogExpanded: 24,
                spaceBetweenDropDownAndItemsDialog: 12,
                padding: const EdgeInsets.symmetric(vertical: 4),
                menuDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black),
                ),
                backgroundDecoration: (child) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Anime',
                      errorText: state.errorText,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      prefixIcon: const Icon(
                        Icons.movie_filter_rounded,
                      ),
                    ),
                    child: child,
                  );
                },
              ),
              builderProps: BuilderProps(
                hintText: const Text('Search Anime...'),
                loadingWidget: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                emptyBuilder: (context, searchEntry) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.sentiment_dissatisfied_rounded,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            searchEntry.isEmpty ? "No records found" : "No match for '$searchEntry'",
                            style: const TextStyle(color: Colors.grey, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                selectedItemBuilder: (context, item) {
                  return Text(
                    item?.title ?? 'None',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
