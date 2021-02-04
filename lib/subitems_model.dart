import 'package:gadjet_inventory/subitem.dart';
import 'package:gadjet_inventory/subcategory.dart';


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ViewModel2 extends ChangeNotifier {
  var subcategoryBox = "subcategoriesBox";
  var subitemsBox = "subitemsBox";
  List<SubCategory> subcategories = [];
  List<SubItem> subitems = [];
  SubItem subitem;

  initHive() async {
    await getAllSubCategories();
  }

  getAllSubCategories() async {
    var box = await Hive.openBox<SubCategory>(subcategoryBox);
    subcategories = box.values.toList();
    notifyListeners();
  }

  addSubCategory(SubCategory subcategory) async {
    print(subcategories.length);
    var box = await Hive.openBox<SubCategory>(subcategoryBox);
    await box.add(subcategory);
    subcategories = box.values.toList();
    print(subcategories.length);
    notifyListeners();
  }

  addSubItem(SubItem subitem) async {
    var box = await Hive.openBox<SubItem>(subitemsBox);
    await box.add(subitem);
    subitems = box.values.toList();
    notifyListeners();
  }

  getAllSubItemsBySubCategory(String subcategoryId) async {
    var box = await Hive.openBox<SubItem>(subitemsBox);
    subitems = box.values.toList().where((subitem) => subitem.subcategoryId == subcategoryId);
    notifyListeners();
  }

  getSubItemById(String id) async {
    subitem = subitems.firstWhere((subitem) => subitem.id == id);
    notifyListeners();
  }
}

registerAdapters() {
  Hive.registerAdapter(SubCategoryAdapter());
  Hive.registerAdapter(SubItemAdapter());
}
