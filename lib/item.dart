import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String categoryId;
  @HiveField(2)
  String company;
  @HiveField(3)
  String modelName;
  @HiveField(4)
  String series;
  @HiveField(5)
  int year;
  @HiveField(6)
  String serialNumber;
  @HiveField(7)
  DateTime warrantDate;
  @HiveField(8)
  String warrantCard;
  @HiveField(9)
  String userGuide;
  @HiveField(10)
  String subcategoryId;

  @override
  String toString() {
    return '$id: $categoryId';
  }
}
