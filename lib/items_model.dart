import 'category.dart';
import 'item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ViewModel extends ChangeNotifier {
  var categoryBox = "categoriesBox";
  var itemsBox = "itemsBox";
  List<Category> categories = [];
  List<Item> items = [];
  Item item;

  initHive() async {
    await getAllCategories();
  }

  getAllCategories() async {
    var box = await Hive.openBox<Category>(categoryBox);
    categories = box.values.toList();
    notifyListeners();
  }

  addCategory(Category category) async {
    print(categories.length);
    var box = await Hive.openBox<Category>(categoryBox);
    await box.add(category);
    categories = box.values.toList();
    print(categories.length);
    notifyListeners();
  }

  addItem(Item item) async {
    var box = await Hive.openBox<Item>(itemsBox);
    await box.add(item);
    items = box.values.toList();
    notifyListeners();
  }

  getAllItemsByCategory(String categoryId) async {
    var box = await Hive.openBox<Item>(itemsBox);
    items = box.values.toList().where((item) => item.categoryId == categoryId);
    notifyListeners();
  }

  getItemById(String id) async {
    item = items.firstWhere((item) => item.id == id);
    notifyListeners();
  }
}

registerAdapters() {
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ItemAdapter());
}
