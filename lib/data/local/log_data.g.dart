// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogDataAdapter extends TypeAdapter<LogData> {
  @override
  final int typeId = 1;

  @override
  LogData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogData(
      color: fields[0] as String,
      requestedAt: fields[1] as DateTime,
      lastAttemptedAt: fields[2] as DateTime,
      finishedAt: fields[3] as DateTime,
      retryCount: fields[4] as int,
      hasFinished: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LogData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.requestedAt)
      ..writeByte(2)
      ..write(obj.lastAttemptedAt)
      ..writeByte(3)
      ..write(obj.finishedAt)
      ..writeByte(4)
      ..write(obj.retryCount)
      ..writeByte(5)
      ..write(obj.hasFinished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
