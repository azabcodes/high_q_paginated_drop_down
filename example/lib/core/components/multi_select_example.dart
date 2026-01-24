import 'package:example/core/services/api_service.dart';
import 'package:example/core/model/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';

class MultiSelectExample extends StatelessWidget {
  final MultiSelectController<AnimeDataModel> controller;

  const MultiSelectExample({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Multi Select',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        HighQDropDown<AnimeDataModel>.multiSelect(
          controller: controller,
          validatorProps: ValidatorProps(
            validator: (List<AnimeDataModel>? value) {
              if (value == null || value.isEmpty) {
                return 'Please select at least one anime';
              }
              return null;
            },
          ),
          itemsLogicProps: ItemsLogicProps(
            asyncItems: (String? filter) async {
              final list = await getAnimeList(page: 1, queryParameters: {"q": filter});
              return list?.animeList ?? [];
            },
            itemAsString: (AnimeDataModel? u) => u?.title ?? '',
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
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
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
      ],
    );
  }
}
