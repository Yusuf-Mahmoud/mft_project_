import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/Theme.dart';
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
  final booksBox = Hive.box('books');

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _genreController.text = widget.book!.genre;
      _publishedDateController.text =
          DateFormat('yyyy').format(widget.book!.publishedDate);
      _copiesAvailableController.text = widget.book!.copiesAvailable.toString();
      _isbnController.text = widget.book!.isbn.toString();
      _bookPageController.text = widget.book!.bookpage.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
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
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a genre';
                  }
                  return null;
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ISBN';
                  }
                  if (value.length != 13) {
                    return 'ISBN must be 13 digits';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid ISBN';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bookPageController,
                decoration: InputDecoration(labelText: 'Book Page'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of book page';
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
                        isbn: int.parse(_isbnController.text),
                        bookpage: int.parse(_bookPageController.text),
                      );

                      booksBox.put(bookId, newBook);
                      Navigator.pop(context, newBook);
                    }
                  },
                  child: Text('Add',
                      style: TextStyle(
                          fontSize: 20, color: apptheme.primarycolor)),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
