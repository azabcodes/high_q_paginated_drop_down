# High Q Paginated DropDown

A comprehensive Flutter package that handles pagination, search, and validation in DropDowns. It supports both single and multi-selection modes, with extensive customization options.

## Features

- **Pagination Support**: Efficiently handle large lists with pagination.
- **Searchable**: Built-in search functionality to filter items.
- **Single & Multi Select**: Support for selecting one or multiple items.
- **Form Integration**: Works seamlessly with Flutter's `Form` widget for validation.
- **Highly Customizable**: Customize icons, decorations, builders, and more.
- **Async Loading**: Support for fetching data asynchronously.

## Installation

Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  high_q_paginated_drop_down: ^2.1.4
```

Then import it in your file:

```dart
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';
```

## Usage

This package provides a unified widget `HighQDropDown`. You can use the main constructor for standard single-selection, or named constructors for other modes:

1. **`HighQDropDown(...)`** - Main constructor. Use this for basic single selection with a provided list of items.
2. **`HighQDropDown.paginated(...)`** - Use this for single selection where items are fetched asynchronously with pagination.
3. **`HighQDropDown.multiSelect(...)`** - Use this for multi-selection from a provided list.
4. **`HighQDropDown.paginatedMultiSelect(...)`** - Use this for multi-selection with paginated asynchronous data.

> **Note**: For backward compatibility or specific use cases, you can still access the underlying widgets directly:
>
> - `HighQSingleDropDown`: Equivalent to `HighQDropDown()`.
> - `HighQPaginatedDropdown`: Equivalent to `HighQDropDown.paginated()`.
> - `HighQMultiSelectDropDown`: Equivalent to `HighQDropDown.multiSelect()`.
> - `HighQMultiSelectPaginatedDropDown`: Equivalent to `HighQDropDown.paginatedMultiSelect()`.

<img width="1344" height="2992" alt="Screenshot_1769265789" src="https://github.com/user-attachments/assets/65a015e5-030d-44d8-bfc4-4219ecac8767" />


https://github.com/user-attachments/assets/d5e814e9-40b1-477f-91f9-e526838985df



https://github.com/user-attachments/assets/febe2be0-6d12-4625-965e-75b384d0eaef






