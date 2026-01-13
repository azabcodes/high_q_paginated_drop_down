import 'package:example/pagination_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PaginatedSearchDropdownController<Anime> searchableDropdownController1 =
      PaginatedSearchDropdownController<Anime>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HighQ Dropdown Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.indigo, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF8F9FC),
        appBar: AppBar(
          title: const Text(
            'HighQ Dropdown',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Text(
                        'Discover Anime',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Search and select your favorite anime from the list below.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      FormField<Anime>(
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an anime';
                          }
                          return null;
                        },
                        builder: (FormFieldState<Anime> state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HighQPaginatedDropdown<Anime>.paginated(
                                controller: searchableDropdownController1,
                                requestItemCount: 25,
                                textFieldDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                width: double.infinity,
                                loadingWidget: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
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
                                hintText: const Text('Search Anime...'),
                                paginatedRequest: (int page, String? searchText) async {
                                  final AnimePaginatedList? paginatedList = await getAnimeList(
                                    page: page,
                                    queryParameters: {
                                      'page': page,
                                      "q": searchText,
                                    },
                                  );
                                  return paginatedList?.animeList?.map((e) {
                                    return MenuItemModel<Anime>(
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                onChanged: (Anime? value) {
                                  debugPrint('$value');
                                  state.didChange(value);
                                },
                                hasTrailingClearIcon: true,
                                trailingIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 24,
                                ),
                                searchHintText: 'Type to search anime...',
                                trailingClearIcon: const Icon(
                                  Icons.clear_rounded,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                searchDelayDuration: const Duration(
                                  milliseconds: 500,
                                ),
                                spaceBetweenDropDownAndItemsDialog: 12,
                                isEnabled: true,
                                onTapWhileDisableDropDown: () {},
                                isDialogExpanded: false,
                                showTextField: true,
                                paddingValueWhileIsDialogExpanded: 24,
                                noRecordText: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'No anime found',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
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
                                menuDecoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        if (kDebugMode) {
                          print('Form is valid!');
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selected: ${searchableDropdownController1.selectedItem.value?.value?.title}',
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      } else {
                        if (kDebugMode) {
                          print('Form is invalid!');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Submit Selection',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<AnimePaginatedList?> getAnimeList({
  required int page,
  Map<String, dynamic>? queryParameters,
}) async {
  try {
    String url = "https://api.jikan.moe/v4/anime";

    Response<dynamic> response = await Dio().get(url, queryParameters: queryParameters).then((value) {
      return value;
    });
    if (response.statusCode != 200) throw Exception(response.statusMessage);
    return AnimePaginatedList.fromJson(response.data);
  } catch (exception) {
    throw Exception(exception);
  }
}
