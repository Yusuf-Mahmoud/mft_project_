import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/module/books.dart';

class AddBookPage extends StatefulWidget {
  final Books? book;
  AddBookPage({this.book});
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _publishedDateController =
      TextEditingController();
  final TextEditingController _copiesAvailableController =
      TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _bookPageController = TextEditingController();
  final booksBox = Hive.box<Books>('booksBox');

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _genreController.text = widget.book!.genre;
      _publishedDateController.text =
          DateFormat('yyyy').format(widget.book!.publishedDate);
      _copiesAvailableController.text = widget.book!.copiesAvailable.toString();
      _isbnController.text = widget.book!.isbn?.toString() ?? '';
      _bookPageController.text = widget.book!.bookpage?.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _genreController.text.isNotEmpty
                    ? _genreController.text
                    : null,
                decoration: InputDecoration(labelText: 'Genre'),
                items: <String>[
                  'Mathematics / رياضيات',
                  'Accounting/ محاسبة',
                  'Management/ إدارة',
                  'Economics / اقتصاد',
                  'Computer Science / علوم الحاسب',
                  'Various Sciences / علوم متنوعة',
                  'Treatises /  رسائل علمية',
                  'Islamic Sciences / العلوم الاسلامية',
                  'Politics / سياسة',
                  'Law / قانون',
                  'Miscellaneous / متنوعة',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _genreController.text = newValue!;
                  });
                },
              ),
              TextFormField(
                controller: _publishedDateController,
                decoration: InputDecoration(labelText: 'Published Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a published date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _copiesAvailableController,
                decoration: InputDecoration(labelText: 'Copies Available'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of copies available';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length != 13) {
                      return 'ISBN must be 13 digits';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid ISBN';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bookPageController,
                decoration: InputDecoration(labelText: 'Book Page'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of book pages';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      bool titleExists = false;
                      bool isbnExists = false;
                      widget.book != null
                          ? booksBox.values.forEach((existingBook) {
                              if (existingBook.title == _titleController.text &&
                                  existingBook.bookid != widget.book!.bookid) {
                                titleExists = true;
                              }
                              if (existingBook.isbn?.toString() ==
                                      _isbnController.text &&
                                  existingBook.bookid != widget.book!.bookid) {
                                isbnExists = true;
                              }
                            })
                          : booksBox.values.forEach((existingBook) {
                              if (existingBook.title == _titleController.text) {
                                titleExists = true;
                              }
                              if (existingBook.isbn?.toString() ==
                                  _isbnController.text) {
                                isbnExists = true;
                              }
                            });

                      if (titleExists) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Title Already Exists'),
                              content: Text(
                                  'A book with the same title already exists.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (isbnExists) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('ISBN Already Exists'),
                              content: Text(
                                  'A book with the same ISBN already exists.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        final bookId = widget.book != null
                            ? widget.book!.bookid
                            : booksBox.length + 1;
                        final newBook = Books(
                          bookid: bookId,
                          title: _titleController.text,
                          genre: _genreController.text,
                          publishedDate: DateTime(
                              int.parse(_publishedDateController.text), 1, 1),
                          copiesAvailable:
                              int.parse(_copiesAvailableController.text),
                          isbn: _isbnController.text.isNotEmpty
                              ? int.parse(_isbnController.text)
                              : null,
                          bookpage: int.parse(_bookPageController.text),
                        );

                        booksBox.put(bookId, newBook);
                        Navigator.pop(context, newBook);
                      }
                    }
                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.button?.color ??
                          Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.button?.color ??
                          Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
