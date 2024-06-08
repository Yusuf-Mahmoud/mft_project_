import 'package:hive/hive.dart';

part 'books.g.dart';

@HiveType(typeId: 0)
class Books {
  @HiveField(0)
  int bookid;
  @HiveField(1)
  String title;
  @HiveField(2)
  int? isbn;
  @HiveField(3)
  String genre;
  @HiveField(4)
  DateTime publishedDate;
  @HiveField(5)
  int copiesAvailable;
  @HiveField(6)
  int? bookpage;

  Books({
    required this.bookid,
    required this.title,
    this.isbn,
    required this.genre,
    required this.publishedDate,
    required this.copiesAvailable,
    required this.bookpage,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookid': bookid,
      'title': title,
      'isbn': isbn,
      'genre': genre,
      'publishedDate': publishedDate.millisecondsSinceEpoch,
      'copiesAvailable': copiesAvailable,
      'bookpage': bookpage,
    };
  }

  static Books fromMap(Map<String, dynamic> map) {
    return Books(
      bookid: map['bookid'],
      title: map['title'],
      isbn: map['isbn'],
      genre: map['genre'],
      publishedDate: DateTime.fromMillisecondsSinceEpoch(map['publishedDate']),
      copiesAvailable: map['copiesAvailable'],
      bookpage: map['bookpage'],
    );
  }

  Future<void> save() async {
    final box = await Hive.openBox<Books>('booksBox');
    await box.put(bookid, this);
  }

  Future<void> delete() async {
    final box = await Hive.openBox<Books>('booksBox');
    await box.delete(bookid);
  }

  Future<void> update() async {
    final box = await Hive.openBox<Books>('booksBox');
    await box.put(bookid, this);
  }

  static Future<Books?> get(int id) async {
    final box = await Hive.openBox<Books>('booksBox');
    return box.get(id);
  }

  // minus number of copies of a book using the book title
}
