// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksAdapter extends TypeAdapter<Books> {
  @override
  final int typeId = 0;

  @override
  Books read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Books(
      bookid: fields[0] as int,
      title: fields[1] as String,
      isbn: fields[2] as int,
      genre: fields[3] as String,
      publishedDate: fields[4] as DateTime,
      copiesAvailable: fields[5] as int,
      bookpage: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Books obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bookid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isbn)
      ..writeByte(3)
      ..write(obj.genre)
      ..writeByte(4)
      ..write(obj.publishedDate)
      ..writeByte(5)
      ..write(obj.copiesAvailable)
      ..writeByte(6)
      ..write(obj.bookpage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
