import 'package:example/core/model/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';

class EmptyDataExample extends StatefulWidget {
  final HighQPaginatedDropdownController<AnimeDataModel> controller;

  const EmptyDataExample({Key? key, required this.controller}) : super(key: key);

  @override
  State<EmptyDataExample> createState() => _EmptyDataExampleState();
}

class _EmptyDataExampleState extends State<EmptyDataExample> {
  late final HighQPaginatedDropdownController<AnimeDataModel> _singlePaginatedController;
  late final MultiSelectController<AnimeDataModel> _multiController;
  late final MultiSelectController<AnimeDataModel> _multiPaginatedController;

  @override
  void initState() {
    super.initState();
    _singlePaginatedController = HighQPaginatedDropdownController<AnimeDataModel>();
    _multiController = MultiSelectController<AnimeDataModel>();
    _multiPaginatedController = MultiSelectController<AnimeDataModel>();
  }

  @override
  void dispose() {
    _singlePaginatedController.dispose();
    _multiController.dispose();
    _multiPaginatedController.dispose();
    super.dispose();
  }

  Widget _buildEmptyState(BuildContext context, String searchEntry) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_rounded,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'No data available',
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Empty Data Examples',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),

        // Single Select Empty
        const Text("1. Single Select (Empty List)", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        HighQDropDown<AnimeDataModel>(
          controller: widget.controller,
          enabled: true,
          items: const [],

          onChanged: (AnimeDataModel? value) {},
          onDisabledTap: () {},

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
                decoration: const InputDecoration(
                  labelText: 'Anime',

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  prefixIcon: Icon(
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
            emptyBuilder: _buildEmptyState,
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
        ),
        const SizedBox(height: 15),

        // Single Select Paginated Empty
        const Text("2. Single Paginated (Empty Future)", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        HighQDropDown<AnimeDataModel>.paginated(
          controller: _singlePaginatedController,
          requestProps: PaginatedRequestProps(
            paginatedRequest: (page, filter) async => [],
          ),
          enabled: true,
          onChanged: (AnimeDataModel? value) {},
          onDisabledTap: () {},

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
                decoration: const InputDecoration(
                  labelText: 'Anime',

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  prefixIcon: Icon(
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
            emptyBuilder: _buildEmptyState,
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
        ),
        const SizedBox(height: 15),

        // Multi Select Empty
        const Text("3. Multi Select (Empty List)", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        HighQDropDown<AnimeDataModel>.multiSelect(
          controller: _multiController,
          itemsLogicProps: ItemsLogicProps(
            items: [],
            itemAsString: (AnimeDataModel? u) => u?.title ?? '',
          ),
          validatorProps: ValidatorProps(
            validator: (List<AnimeDataModel>? value) {
              if (value == null || value.isEmpty) {
                return 'Please select at least one anime';
              }
              return null;
            },
          ),
          methodLogicProps: MethodLogicProps(
            onChanged: (List<AnimeDataModel> value) {
              debugPrint('Multi Select: ${value.map((e) => e.title).join(', ')}');
            },
          ),
          dropdownDecorator: const DropDownDecoratorProps(
            textAlign: TextAlign.left,
            baseStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            multiSelectDropDownDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              labelText: 'Select Animes',
              hintText: 'Select at least one anime',
            ),
          ),
          selectedItemDecorationPros: SelectedItemDecorationPros(
            selectedItemBoxDecoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
            ),
            selectedItemTextStyle: const TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            selectedItemBoxPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            removeItemWidget: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(Icons.close_rounded, size: 14, color: Colors.indigo),
            ),
          ),
          popupProps: PopupPropsMultiSelection.menu(
            menuProps: MenuProps(
              elevation: 4,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            emptyBuilder: _buildEmptyState,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                labelText: 'Search',
                hintText: 'Search',
              ),
            ),
          ),
          makeButtonsInRow: true,
          confirmButtonProps: ConfirmButtonProps(
            builder: (onPressed) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          cancelButtonProps: CancelButtonProps(
            builder: (onPressed) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    debugPrint("Custom Cancel Tapped");
                    onPressed();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.redAccent, Colors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),

        // Multi Select Paginated Empty
        const Text("4. Multi Paginated (Empty Future)", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        HighQDropDown<AnimeDataModel>.paginatedMultiSelect(
          controller: _multiPaginatedController,
          paginatedRequest: (int page, String? filter) async {
            return [];
          },
          requestItemCount: 25,
          validatorProps: ValidatorProps(
            validator: (List<AnimeDataModel>? value) {
              if (value == null || value.isEmpty) {
                return 'Please select at least one anime';
              }
              return null;
            },
          ),
          itemsLogicProps: ItemsLogicProps(
            itemAsString: (AnimeDataModel? u) => u?.title ?? '',
          ),
          methodLogicProps: MethodLogicProps(
            onChanged: (List<AnimeDataModel> value) {
              debugPrint('Multi Select Paginated: ${value.map((e) => e.title).join(', ')}');
            },
          ),
          dropdownDecorator: const DropDownDecoratorProps(
            textAlign: TextAlign.left,
            baseStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            multiSelectDropDownDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              labelText: 'Select Animes (Paginated)',
              hintText: 'Select at least one anime',
            ),
          ),
          selectedItemDecorationPros: SelectedItemDecorationPros(
            selectedItemBoxDecoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
            ),
            selectedItemTextStyle: const TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            selectedItemBoxPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            removeItemWidget: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(Icons.close_rounded, size: 14, color: Colors.purple),
            ),
          ),
          popupProps: PopupPropsMultiSelection.menu(
            menuProps: MenuProps(
              elevation: 4,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            emptyBuilder: _buildEmptyState,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                labelText: 'Search',
                hintText: 'Search',
              ),
            ),
          ),
          makeButtonsInRow: true,
          confirmButtonProps: ConfirmButtonProps(
            builder: (onPressed) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          cancelButtonProps: CancelButtonProps(
            builder: (onPressed) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    debugPrint("Custom Cancel Tapped");
                    onPressed();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.redAccent, Colors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
