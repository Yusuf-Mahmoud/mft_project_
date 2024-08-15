import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/Tabs/isseudbook/isseudbookbuttonadd.dart';
import 'package:mft_final_project/Theme.dart';

import '../../core/functions.dart';
import '../../module/borrowed_book.dart';

class IsseudBook extends StatefulWidget {
  @override
  State<IsseudBook> createState() => _IsseudBookState();
}

class _IsseudBookState extends State<IsseudBook> {
  List<BorrowedBook> borrowedBooks = [];
  List<BorrowedBook> filteredBorrowedBooks = [];
  final borrowedBookBox = Hive.box('borrowedBookBox');
  final books = Hive.box('books');
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
    List<String> translateisseud = [
      AppLocalizations.of(context)!.bookname,
      AppLocalizations.of(context)!.isname,
      AppLocalizations.of(context)!.iscode,
      AppLocalizations.of(context)!.issuedate,
      AppLocalizations.of(context)!.duedate,
      AppLocalizations.of(context)!.actions,
      AppLocalizations.of(context)!.adddbook,
      AppLocalizations.of(context)!.returnbook,
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
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
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: apptheme.primarycolor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Export As:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Tools().exportToCSVBorrowedBooks(
                                    borrowedBooks, context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Excel CSV file',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: apptheme.primarycolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Tools().exportToPDFBorrowedBooks(
                                    borrowedBooks, context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    'PDF file',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.pinkAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // Tools().exportToCSVBooks(books);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF86676),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                    child: Text('Export Tables',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 1,
            child: Text(
              translateisseud[0],
              style: TextStyle(fontSize: 17, color: textColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(translateisseud[1],
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
            flex: 1,
            child: Text(translateisseud[2],
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
            flex: 1,
            child: Text(translateisseud[3],
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
            flex: 1,
            child: Text(translateisseud[4],
                style: TextStyle(fontSize: 17, color: textColor)),
          ),
          Expanded(
              flex: 1,
              child: Text(translateisseud[5],
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
                    Text(
                      textAlign: TextAlign.left,
                      '${borrowedBook.booktitle}',
                      style: TextStyle(fontSize: 17, color: textColor),
                    ),
                    Expanded(
                        child: Center(
                      child: Text('${borrowedBook.memberName}',
                          style: TextStyle(fontSize: 17, color: textColor)),
                    )),
                    Expanded(
                        child: Center(
                      child: Text('${borrowedBook.membercode}',
                          style: TextStyle(fontSize: 17, color: textColor)),
                    )),
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
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => AddBorrowed(
                    //           borrowedBook: borrowedBook,
                    //           borrowedBooks: [],
                    //         ),
                    //       ),
                    //     ).then((updateborrowed) {
                    //       if (updateborrowed != null) {
                    //         setState(() {
                    //           borrowedBookBox.put(
                    //               updateborrowed.membercode, updateborrowed);
                    //           borrowedBooks[index] = updateborrowed;
                    //           filterBorrowedBooks(searchController.text);
                    //         });
                    //       }
                    //     });
                    //   },
                    //   style: Theme.of(context).elevatedButtonTheme.style,
                    //   child: Text(
                    //     'Renew',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       color: Theme.of(context).textTheme.button?.color ??
                    //           Colors.black,
                    //     ),
                    //   ),
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() async {
                          borrowedBookBox.deleteAt(index);
                          borrowedBooks.removeAt(index);
                          filterBorrowedBooks(searchController.text);

                          try {
                            final book = books.values.firstWhere(
                              (element) =>
                                  element.title.toLowerCase() ==
                                  borrowedBook.booktitle.toLowerCase(),
                            );
                            book.copiesAvailable += 1;

                            await books.put(book.bookid, book);
                          } catch (e) {
                            // Handle the case where the book is not found
                            print('Book not found');
                          }

                          setState(() {});
                        });
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        translateisseud[7],
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
            translateisseud[6],
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
