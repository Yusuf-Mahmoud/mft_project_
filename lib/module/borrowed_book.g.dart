// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrowed_book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BorrowedBookAdapter extends TypeAdapter<BorrowedBook> {
  @override
  final int typeId = 2;

  @override
  BorrowedBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BorrowedBook(
      booktitle: fields[0] as String,
      memberName: fields[1] as String,
      membercode: fields[2] as String,
      borrowedDate: fields[3] as DateTime,
      returnDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BorrowedBook obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.booktitle)
      ..writeByte(1)
      ..write(obj.memberName)
      ..writeByte(2)
      ..write(obj.membercode)
      ..writeByte(3)
      ..write(obj.borrowedDate)
      ..writeByte(4)
      ..write(obj.returnDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorrowedBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
