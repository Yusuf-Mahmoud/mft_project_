import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/Tabs/isseudbook/buttonadd.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search',
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
            child: Text(
              'Book Title',
              style: _textStyle(context),
            ),
          ),
          Expanded(
            child: Text('Member Name', style: _textStyle(context)),
          ),
          Expanded(
            child: Text('Member Code', style: _textStyle(context)),
          ),
          Expanded(
            child: Text('Borrowed Date', style: _textStyle(context)),
          ),
          Expanded(
            child: Text('Return Date', style: _textStyle(context)),
          ),
          Expanded(child: Text('Actions', style: _textStyle(context))),
        ]),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: filteredBorrowedBooks.length,
            itemBuilder: (context, index) {
              final borrowedBook = filteredBorrowedBooks[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      '${borrowedBook.booktitle}',
                      style: _textStyle(context),
                    )),
                    Expanded(
                        child: Text('${borrowedBook.memberName}',
                            style: _textStyle(context))),
                    Expanded(
                        child: Text('${borrowedBook.membercode}',
                            style: _textStyle(context))),
                    Expanded(
                      child: Text(
                          '${DateFormat('yyyy-MM-dd').format(borrowedBook.borrowedDate)}',
                          style: _textStyle(context)),
                    ),
                    Expanded(
                      child: Text(
                          '${DateFormat('yyyy-MM-dd').format(borrowedBook.returnDate)}',
                          style: _textStyle(context)),
                    ),
                  ],
                ),
                trailing: Expanded(
                  child: Row(
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
                        child: Text('Edit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            borrowedBookBox.deleteAt(index);
                            borrowedBooks.removeAt(index);
                            filterBorrowedBooks(searchController.text);
                          });
                        },
                        child: Text('Return'),
                      ),
                    ],
                  ),
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
          child: const Text('Add Book'),
        ),
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
