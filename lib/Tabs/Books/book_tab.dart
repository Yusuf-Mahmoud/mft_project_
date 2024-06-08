import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/Tabs/Books/bookbuttonadd.dart';
import 'package:mft_final_project/module/books.dart';

import '../../core/functions.dart';

class BookTab extends StatefulWidget {
  final List<Books> books;

  BookTab({required this.books});
  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  List<Books> books = [];
  List<Books> filteredBooks = [];
  final booksBox = Hive.box('books');
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    books = widget.books;
    filteredBooks = books;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1?.color;

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
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                  ),
                  onChanged: (value) {
                    filterBooks(value);
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
                        decoration: const BoxDecoration(
                          color: Colors.pinkAccent,
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
                                Tools().exportToCSVBooks(books);
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
                                    'Excel CSV file',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.pinkAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Tools().exportToPDFBooks(books);
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
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Center(
                    child: Text('Export Tables',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('ID',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Genre',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Published Date',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Copies Available',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('ISBN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('bookpage',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Text('Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              final book = filteredBooks[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      '${book.bookid}',
                      style: TextStyle(fontSize: 17, color: textColor),
                    )),
                    Expanded(
                        child: Text(
                      '${book.title}',
                      style: TextStyle(fontSize: 17, color: textColor),
                    )),
                    Expanded(
                        child: Text(
                      '${book.genre}',
                      style: TextStyle(fontSize: 17, color: textColor),
                    )),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${DateFormat('yyyy').format(book.publishedDate)}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                      '${book.copiesAvailable}',
                      style: TextStyle(fontSize: 17, color: textColor),
                    ))),
                    Expanded(
                        child: Text(
                      '${book.isbn}',
                      style: TextStyle(fontSize: 17, color: textColor),
                    )),
                    Expanded(
                        child: Center(
                            child: Text(
                      '${book.bookpage}',
                      style: TextStyle(fontSize: 17, color: textColor),
                    ))),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBookPage(book: book),
                          ),
                        ).then((updatedBook) {
                          if (updatedBook != null) {
                            setState(() {
                              booksBox.put(updatedBook.bookid, updatedBook);
                              books[index] = updatedBook;
                              filterBooks(searchController.text);
                            });
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        Tools().exportToCSVBooks(books);
                        // setState(() {
                        //   booksBox.delete(book.bookid);
                        //   books.removeAt(index);
                        //   filterBooks(searchController.text);
                        // });
                      },
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
                    child: AddBookPage(),
                  ),
                );
              },
            ).then((newBook) {
              if (newBook != null && newBook is Books) {
                setState(() {
                  books.add(newBook);
                  filterBooks(searchController.text);
                });
              }
            });
          },
          style: Theme.of(context).elevatedButtonTheme.style,
          child: Text(
            'Add Book',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.button?.color ?? Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void filterBooks(String query) {
    setState(() {
      filteredBooks = books.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.genre.toLowerCase().contains(query.toLowerCase()) ||
            DateFormat('yyyy').format(book.publishedDate).contains(query) ||
            book.copiesAvailable.toString().contains(query) ||
            book.isbn.toString().contains(query);
      }).toList();
    });
  }

  void _updateBook(Books updatedBook) {
    final index = books.indexWhere((book) => book.bookid == updatedBook.bookid);
    if (index != -1) {
      setState(() {
        books[index] = updatedBook;
        filterBooks(searchController.text);
      });
    } else {
      setState(() {
        books.add(updatedBook);
        filterBooks(searchController.text);
      });
    }
  }
}
