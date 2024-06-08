import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../module/books.dart';
import '../module/borrowed_book.dart';
import '../module/member.dart';

class Tools {
  Future<void> exportToCSVBooks(List<Books> books) async {
    List<List<dynamic>> rows = [];
    rows.add([
      "Book Title",
      "Book Id",
      "Pages",
      "Genre",
      "Copies Available",
      "ISBN",
      "Published Date",
    ]);

    for (var book in books) {
      List<dynamic> row = [];
      row.add(book.title);
      row.add(book.bookid);
      row.add((book.bookpage).toString());
      row.add(book.genre);
      row.add(book.copiesAvailable);
      row.add(book.isbn != null
          ? "'${book.isbn.toString()}"
          : ""); // Format ISBN as text
      row.add(book.publishedDate.year.toString());
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final utf8Csv = '\uFEFF$csv';

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/books.csv";
    final file = File(path);
    await file.writeAsString(utf8Csv, encoding: utf8);

    print("CSV exported to $path");
  }

  Future<void> exportToPDFBooks(List<Books> books) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: [
              "Book Title",
              "Book Id",
              "Pages",
              "Genre",
              "Copies Available",
              "ISBN",
              "Published Date",
            ],
            data: books.map((book) {
              return [
                book.title,
                book.bookid,
                book.bookpage.toString(),
                book.genre,
                book.copiesAvailable,
                book.isbn.toString(),
                book.publishedDate.year.toString(),
              ];
            }).toList(),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/books.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    print("PDF exported to $path");
  }

  Future<void> exportToCSVBorrowedBooks(
      List<BorrowedBook> borrowedBooks) async {
    List<List<dynamic>> rows = [];
    rows.add([
      "Book Title",
      "Borrowed Date",
      "Member Name",
      "Member Code",
      "Return Date",
    ]);

    for (var book in borrowedBooks) {
      List<dynamic> row = [];
      row.add(book.booktitle);
      row.add(
          '${book.borrowedDate.year} - ${book.borrowedDate.month} - ${book.borrowedDate.day}');
      row.add(book.memberName);
      row.add(book.membercode);

      row.add(
          '${book.returnDate.year} - ${book.returnDate.month} - ${book.returnDate.day}');
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/borrowedBooks.csv";
    final file = File(path);
    await file.writeAsString(csv);

    print("CSV exported to $path");
  }

  Future<void> exportToPDFBorrowedBooks(
      List<BorrowedBook> borrowedBooks) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: [
              "Book Title",
              "Borrowed Date",
              "Member Name",
              "Member Code",
              "Return Date",
            ],
            data: borrowedBooks.map((book) {
              return [
                book.booktitle,
                '${book.borrowedDate.year} - ${book.borrowedDate.month} - ${book.borrowedDate.day}',
                book.memberName,
                book.membercode,
                '${book.returnDate.year} - ${book.returnDate.month} - ${book.returnDate.day}',
              ];
            }).toList(),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/borrowedBooks.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    print("PDF exported to $path");
  }

  Future<void> exportToCSVMembers(List<Member> members) async {
    List<List<dynamic>> rows = [];
    rows.add([
      "Member Id",
      "Member Name",
      "Member Code",
      "Department",
      "Gender",
      "Note",
    ]);

    for (var member in members) {
      List<dynamic> row = [];
      row.add(member.Memberid);
      row.add(member.Membername);
      row.add(member.Membercode);
      row.add(member.department);
      row.add(member.Gender);
      row.add(member.Note);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/members.csv";
    final file = File(path);
    await file.writeAsString(csv);

    print("CSV exported to $path");
  }

  Future<void> exportToPDFMembers(List<Member> members) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: [
              "Member Id",
              "Member Name",
              "Member Code",
              "Department",
              "Gender",
              "Note",
            ],
            data: members.map((member) {
              return [
                member.Memberid,
                member.Membername,
                member.Membercode,
                member.department,
                member.Gender,
                member.Note,
              ];
            }).toList(),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/members.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    print("PDF exported to $path");
  }
}
