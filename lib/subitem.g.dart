// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subitem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubItemAdapter extends TypeAdapter<SubItem> {
  @override
  final int typeId = 0;

  @override
  SubItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubItem()
      ..id = fields[0] as String
      ..subcategoryId = fields[1] as String
      ..company = fields[2] as String
      ..modelName = fields[3] as String
      ..series = fields[4] as String
      ..year = fields[5] as int
      ..serialNumber = fields[6] as String
      ..warrantDate = fields[7] as DateTime
      ..warrantCard = fields[8] as String
      ..userGuide = fields[9] as String;
  }

  @override
  void write(BinaryWriter writer, SubItem obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subcategoryId)
      ..writeByte(2)
      ..write(obj.company)
      ..writeByte(3)
      ..write(obj.modelName)
      ..writeByte(4)
      ..write(obj.series)
      ..writeByte(5)
      ..write(obj.year)
      ..writeByte(6)
      ..write(obj.serialNumber)
      ..writeByte(7)
      ..write(obj.warrantDate)
      ..writeByte(8)
      ..write(obj.warrantCard)
      ..writeByte(9)
      ..write(obj.userGuide);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubItemAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
