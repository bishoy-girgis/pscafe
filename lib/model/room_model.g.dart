// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomModelAdapter extends TypeAdapter<RoomModel> {
  @override
  final int typeId = 0;

  @override
  RoomModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoomModel(
      id: fields[0] as String,
      teamName: fields[1] as String,
      type: fields[2] as String,
      startTime: fields[3] as DateTime,
      price: fields[5] as double?,
      isFinish: fields[4] as bool,
      drinks: (fields[6] as List?)?.cast<String>(),
      numberDrink: (fields[7] as List?)?.cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, RoomModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.teamName)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.isFinish)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.drinks)
      ..writeByte(7)
      ..write(obj.numberDrink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
