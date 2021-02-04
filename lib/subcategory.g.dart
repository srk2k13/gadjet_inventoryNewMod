// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubCategoryAdapter extends TypeAdapter<SubCategory> {
  @override
  final int typeId = 0;

  @override
  SubCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCategory()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..iconName = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, SubCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.iconName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubCategoryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
