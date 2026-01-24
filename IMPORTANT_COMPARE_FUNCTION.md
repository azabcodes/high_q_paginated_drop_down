# ⚠️ IMPORTANT: Using compareFn for Custom Objects

## The Problem

When using the multi-select dropdown with **custom objects** (not primitive types like `String` or `int`), you **MUST** provide a `compareFn` in the `FilterAndCompareProps`. Without it, selected items will not be properly marked as checked when you reopen the dropdown.

## Why This Happens

By default, Dart compares objects using **reference equality** (comparing memory addresses). When you:

1. Select items from an API response
2. Close the dropdown
3. Reopen the dropdown (which fetches new data)

The new API response creates **new object instances** with the same data. Even though the data is identical, Dart sees them as different objects because they have different memory addresses.

## The Solution

Always provide a `compareFn` that compares objects by their **unique identifier** (like an ID field):

```dart
HighQDropDown<MyModel>.multiSelect(
  // ... other properties
  filterAndCompareProps: FilterAndCompareProps(
    compareFn: (item1, item2) => item1.id == item2.id,
  ),
)
```

## Examples

### Example 1: Comparing by ID

```dart
class User {
  final int id;
  final String name;
  
  User({required this.id, required this.name});
}

// In your dropdown:
filterAndCompareProps: FilterAndCompareProps(
  compareFn: (user1, user2) => user1.id == user2.id,
)
```

### Example 2: Comparing by Multiple Fields

```dart
class Product {
  final String sku;
  final String name;
  
  Product({required this.sku, required this.name});
}

// In your dropdown:
filterAndCompareProps: FilterAndCompareProps(
  compareFn: (product1, product2) => product1.sku == product2.sku,
)
```

### Example 3: When You DON'T Need compareFn

You only need `compareFn` for custom objects. For primitive types, it's optional:

```dart
// String - no compareFn needed
HighQDropDown<String>.multiSelect(
  // ... works fine without compareFn
)

// int - no compareFn needed
HighQDropDown<int>.multiSelect(
  // ... works fine without compareFn
)
```

## Alternative Solution: Override == and hashCode

Instead of providing `compareFn`, you can override `==` and `hashCode` in your model class:

```dart
class User {
  final int id;
  final String name;
  
  User({required this.id, required this.name});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id;
  
  @override
  int get hashCode => id.hashCode;
}
```

However, using `compareFn` is often more flexible and doesn't require modifying your model classes.

## Summary

 **DO** use `compareFn` when working with custom objects  
 **DO** compare by unique identifiers (like ID fields)  
 **DON'T** rely on default equality for custom objects  
 **DON'T** forget this when items come from API calls  

## See Also

- Check the example files in `example/lib/core/components/` for working implementations
- All multi-select examples now include proper `compareFn` usage
