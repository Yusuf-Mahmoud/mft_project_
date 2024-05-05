import 'package:hive/hive.dart';

part 'borrowed_book.g.dart';

@HiveType(typeId: 2)
class BorrowedBook extends HiveObject {
  @HiveField(0)
  String booktitle;

  @HiveField(1)
  String memberName;

  @HiveField(2)
  String membercode;

  @HiveField(3)
  DateTime borrowedDate;

  @HiveField(4)
  DateTime returnDate;

  BorrowedBook({
    required this.booktitle,
    required this.memberName,
    required this.membercode,
    required this.borrowedDate,
    required this.returnDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'booktitle': booktitle,
      'memberName': memberName,
      'membercode': membercode,
      'borrowedDate': borrowedDate,
      'returnDate': returnDate,
    };
  }

  bool isOverdue() {
    final difference = DateTime.now().difference(returnDate).inDays;
    return difference > 0;
  }

  factory BorrowedBook.fromMap(Map<String, dynamic> map) {
    return BorrowedBook(
      booktitle: map['booktitle'],
      memberName: map['memberName'],
      membercode: map['membercode'],
      borrowedDate: map['borrowedDate'],
      returnDate: map['returnDate'],
    );
  }
}

class BorrowedBookBox {
  static const String boxName = 'borrowedBookBox';

  Future<void> addBorrowedBook(BorrowedBook borrowedBook) async {
    final box = await Hive.openBox<BorrowedBook>(boxName);
    await box.add(borrowedBook);
    await box.close();
  }

  Future<List<BorrowedBook>> getBorrowedBooks() async {
    final box = await Hive.openBox<BorrowedBook>(boxName);
    List<BorrowedBook> borrowedBooks = box.values.toList();
    await box.close();
    return borrowedBooks;
  }

  Future<void> deleteBorrowedBook(int index) async {
    final box = await Hive.openBox<BorrowedBook>(boxName);
    await box.deleteAt(index);
    await box.close();
  }

  Future<void> updateBorrowedBook(
      int index, BorrowedBook newBorrowedBook) async {
    final box = await Hive.openBox<BorrowedBook>(boxName);
    await box.putAt(index, newBorrowedBook);
    await box.close();
  }
}
