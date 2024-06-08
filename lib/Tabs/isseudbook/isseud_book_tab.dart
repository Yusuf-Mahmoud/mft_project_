import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/Tabs/isseudbook/isseudbookbuttonadd.dart';

import '../../module/borrowed_book.dart';

class IsseudBook extends StatefulWidget {
  @override
  State<IsseudBook> createState() => _IsseudBookState();
}

class _IsseudBookState extends State<IsseudBook> {
  List<BorrowedBook> borrowedBooks = [];
  List<BorrowedBook> filteredBorrowedBooks = [];
  final borrowedBookBox = Hive.box('borrowedBookBox');
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    borrowedBooks = borrowedBookBox.values.cast<BorrowedBook>().toList();
    filteredBorrowedBooks = borrowedBooks;
  }

  Color _textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  TextStyle _textStyle(BuildContext context) {
    return TextStyle(
      fontSize: 17,
      color: _textColor(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1?.color;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search Borrowed Books',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            ),
            onChanged: (value) {
              filterBorrowedBooks(value);
            },
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 1,
            child: Text(
              'Book Title',
              style: TextStyle(fontSize: 17, color: textColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('Member Name',
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
            flex: 1,
            child: Text('Member Code',
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
            flex: 1,
            child: Text('Borrowed Date',
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
            flex: 1,
            child: Text('Return Date',
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
              flex: 1,
              child: Text('Actions',
                  style: TextStyle(fontSize: 17, color: textColor))),
        ]),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: filteredBorrowedBooks.length,
            itemBuilder: (context, index) {
              final borrowedBook = filteredBorrowedBooks[index];
              final isOverdue = borrowedBook.isOverdue();
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.left,
                          '${borrowedBook.booktitle}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        )),
                    Expanded(
                        child: Text('${borrowedBook.memberName}',
                            style: TextStyle(fontSize: 17, color: textColor))),
                    Expanded(
                        child: Text('${borrowedBook.membercode}',
                            style: TextStyle(fontSize: 17, color: textColor))),
                    Expanded(
                      child: Text(
                          '${DateFormat('yyyy-MM-dd').format(borrowedBook.borrowedDate)}',
                          style: TextStyle(fontSize: 17, color: textColor)),
                    ),
                    Expanded(
                      child: Text(
                          '${DateFormat('yyyy-MM-dd').format(borrowedBook.returnDate)}',
                          style: TextStyle(fontSize: 17, color: textColor)),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBorrowed(
                              borrowedBook: borrowedBook,
                              borrowedBooks: [],
                            ),
                          ),
                        ).then((updateborrowed) {
                          if (updateborrowed != null) {
                            setState(() {
                              borrowedBookBox.put(
                                  updateborrowed.membercode, updateborrowed);
                              borrowedBooks[index] = updateborrowed;
                              filterBorrowedBooks(searchController.text);
                            });
                          }
                        });
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        'Renew',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.button?.color ??
                              Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          borrowedBookBox.deleteAt(index);
                          borrowedBooks.removeAt(index);
                          filterBorrowedBooks(searchController.text);
                        });
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        'Return',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.button?.color ??
                              Colors.black,
                        ),
                      ),
                    ),
                    if (isOverdue)
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: AddBorrowed(borrowedBooks: borrowedBooks),
                  ),
                );
              },
            ).then((newBorrowed) {
              if (newBorrowed != null) {
                setState(() {
                  borrowedBooks.add(newBorrowed);
                  filterBorrowedBooks(searchController.text);
                });
              }
            });
          },
          style: Theme.of(context).elevatedButtonTheme.style,
          child: Text(
            'Add Borrowed Book',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.button?.color ?? Colors.black,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void filterBorrowedBooks(String query) {
    setState(() {
      filteredBorrowedBooks = borrowedBooks.where((borrowedBook) {
        return borrowedBook.booktitle
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            borrowedBook.memberName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            borrowedBook.membercode.toString().contains(query.toLowerCase()) ||
            DateFormat('yyyy-MM-dd')
                .format(borrowedBook.borrowedDate)
                .contains(query) ||
            DateFormat('yyyy-MM-dd')
                .format(borrowedBook.returnDate)
                .contains(query);
      }).toList();
    });
  }
}
