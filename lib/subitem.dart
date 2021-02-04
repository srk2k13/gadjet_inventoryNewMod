import 'package:hive/hive.dart';

part 'subitem.g.dart';

@HiveType(typeId: 0)
class SubItem extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String subcategoryId;
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


  @override
  String toString() {
    return '$id: $subcategoryId';
  }
}
