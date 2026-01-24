import 'package:example/core/components/empty_data_example.dart';
import 'package:example/core/components/multi_select_example.dart';
import 'package:example/core/components/multi_select_paginated_example.dart';
import 'package:example/core/model/anime_model.dart';
import 'package:example/core/components/single_paginated_example.dart';
import 'package:example/core/components/single_select_example.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final HighQPaginatedDropdownController<AnimeDataModel> searchableDropdownController1 =
      HighQPaginatedDropdownController<AnimeDataModel>();
  final HighQPaginatedDropdownController<AnimeDataModel> singleSelectController =
      HighQPaginatedDropdownController<AnimeDataModel>();
  final HighQPaginatedDropdownController<AnimeDataModel> emptyDataController =
      HighQPaginatedDropdownController<AnimeDataModel>();
  final MultiSelectController<AnimeDataModel> multiSelectController = MultiSelectController<AnimeDataModel>();
  final MultiSelectController<AnimeDataModel> multiSelectPaginatedController = MultiSelectController<AnimeDataModel>();

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
              SinglePaginatedExample(controller: searchableDropdownController1),
              SingleSelectExample(controller: singleSelectController),
              MultiSelectExample(controller: multiSelectController),
              MultiSelectPaginatedExample(controller: multiSelectPaginatedController),
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
                          'Multi: ${multiSelectController.selectedItems.length}\n'
                          'Multi Paginated: ${multiSelectPaginatedController.selectedItems.length}',
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
              EmptyDataExample(controller: emptyDataController),
            ],
          ),
        ),
      ),
    );
  }
}
