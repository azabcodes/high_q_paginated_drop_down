import 'package:example/pagination_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HighQPaginatedDropdownController<Anime> searchableDropdownController1 =
      HighQPaginatedDropdownController<Anime>();
  final HighQPaginatedDropdownController<Anime> singleSelectController = HighQPaginatedDropdownController<Anime>();
  final MultiSelectController<Anime> multiSelectController = MultiSelectController<Anime>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 15,
            children: [
              Text(
                'Single Paginated',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              FormField<Anime>(
                validator: (value) {
                  if (value == null) {
                    return 'Please select an anime';
                  }
                  return null;
                },
                builder: (FormFieldState<Anime> state) {
                  return HighQPaginatedDropdown<Anime>(
                    controller: searchableDropdownController1,
                    enabled: true,
                    onChanged: (Anime? value) {
                      debugPrint('$value');
                      state.didChange(value);
                    },
                    onDisabledTap: () {},
                    requestProps: PaginatedRequestProps(
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
                      requestItemCount: 25,
                    ),
                    searchProps: const PaginatedSearchProps(
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
                    iconProps: const PaginatedIconProps(
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
                    styleProps: PaginatedStyleProps(
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
                    builderProps: PaginatedBuilderProps(
                      hintText: const Text('Search Anime...'),
                      loadingWidget: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                      emptyBuilder: (searchEntry) {
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

              Text(
                'Single Select',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              FutureBuilder<AnimePaginatedList?>(
                future: getAnimeList(page: 1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return FormField(
                    builder: (FormFieldState state) {
                      return HighQDropDown<Anime>(
                        controller: singleSelectController,
                        enabled: true,
                        onChanged: (value) {
                          debugPrint('Single Select: ${value?.title}');
                        },
                        onDisabledTap: () {},
                        items: snapshot.data?.animeList?.map((e) {
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
                        }).toList(),
                        searchProps: const PaginatedSearchProps(
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
                        iconProps: const PaginatedIconProps(
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
                        styleProps: PaginatedStyleProps(
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
                        builderProps: PaginatedBuilderProps(
                          hintText: const Text('Search Anime...'),
                          loadingWidget: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                          emptyBuilder: (searchEntry) {
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
                  );
                },
              ),

              Text(
                'Multi Select',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              HighQMultiSelectDropDown<Anime>(
                controller: multiSelectController,
                validatorProps: ValidatorProps(
                  validator: (List<Anime>? value) {
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
                  itemAsString: (Anime? u) => u?.title ?? '',
                ),
                methodLogicProps: MethodLogicProps(
                  onChanged: (List<Anime> value) {
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
                popupProps: const PopupPropsMultiSelection.menu(
                  searchFieldProps: TextFieldProps(
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
              const SizedBox(height: 24),

              MaterialButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    if (kDebugMode) {
                      print('Form is valid!');
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Paginated: ${searchableDropdownController1.selectedItem.value?.value?.title}\n'
                          'Single: ${singleSelectController.selectedItem.value?.value?.title}\n'
                          'Multi: ${multiSelectController.selectedItems.length}',
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
                color: Colors.indigo,
                minWidth: double.infinity,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Submit Selection',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
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

    final response = await Dio().get(url, queryParameters: queryParameters).then((value) {
      return value;
    });
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
    return AnimePaginatedList.fromJson(response.data);
  } catch (exception) {
    throw Exception(exception);
  }
}
