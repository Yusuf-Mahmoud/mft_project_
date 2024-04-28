// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberAdapter extends TypeAdapter<Member> {
  @override
  final int typeId = 1;

  @override
  Member read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Member(
      Memberid: fields[0] as int,
      Membercode: fields[1] as String,
      Membername: fields[2] as String,
      Gender: fields[3] as String,
      department: fields[4] as String,
      Note: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Member obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.Memberid)
      ..writeByte(1)
      ..write(obj.Membercode)
      ..writeByte(2)
      ..write(obj.Membername)
      ..writeByte(3)
      ..write(obj.Gender)
      ..writeByte(4)
      ..write(obj.department)
      ..writeByte(5)
      ..write(obj.Note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
