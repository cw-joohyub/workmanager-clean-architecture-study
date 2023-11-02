// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumberDataAdapter extends TypeAdapter<NumberData> {
  @override
  final int typeId = 0;

  @override
  NumberData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumberData(
      value: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NumberData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
