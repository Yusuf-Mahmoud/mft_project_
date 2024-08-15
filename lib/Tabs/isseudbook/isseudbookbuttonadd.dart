import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mft_final_project/module/borrowed_book.dart';

class AddBorrowed extends StatefulWidget {
  final BorrowedBook? borrowedBook;
  final List<BorrowedBook> borrowedBooks;

  AddBorrowed({this.borrowedBook, required this.borrowedBooks});
  @override
  State<AddBorrowed> createState() => _AddBorrowedState();
}

class _AddBorrowedState extends State<AddBorrowed> {
  String? selectedBookTitle;
  final TextEditingController memberNameController = TextEditingController();
  final TextEditingController memberCodeController = TextEditingController();
  final borrowedBookBox = Hive.box('borrowedBookBox');
  final membersBox = Hive.box('members');
  final books = Hive.box('books');

  @override
  Widget build(BuildContext context) {
    if (widget.borrowedBook != null) {
      memberNameController.text = widget.borrowedBook!.memberName;
      memberCodeController.text = widget.borrowedBook!.membercode;
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: DropdownButtonFormField<String>(
              value: selectedBookTitle,
              items: books.values
                  .map((book) => DropdownMenuItem<String>(
                        value: book
                            .title, // Assuming `title` is a property of `Books`
                        child: Text(book.title),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedBookTitle = value;
                });
              },
              decoration: InputDecoration(labelText: 'Book Title'),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: TextFormField(
              controller: memberNameController,
              decoration: InputDecoration(labelText: 'Member Name'),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: TextFormField(
              controller: memberCodeController,
              decoration: InputDecoration(labelText: 'Member Code'),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: ElevatedButton(
              onPressed: () async {
                // تحقق مما إذا كان الكتاب والشخص موجودين في Hive
                // final book = await borrowedBookBox.values.firstWhere(
                //   (borrowedBook) =>
                //       borrowedBook.booktitle.trim().toLowerCase() ==
                //       bookTitleController.text.trim().toLowerCase(),
                //   orElse: () => null,
                // );
                final book = books.values.firstWhere(
                  (element) =>
                      element.title.toLowerCase() ==
                      selectedBookTitle.toString().toLowerCase(),
                );
                if (book.copiesAvailable < 3) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content:
                          Text('This book is not available for borrowing.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                final member = await membersBox.values.firstWhere(
                  (member) => member.Membercode == memberCodeController.text,
                  orElse: () => null,
                );

                final alreadyBorrowed = widget.borrowedBooks.any(
                    (borrowedBook) =>
                        borrowedBook.membercode == memberCodeController.text);

                if (member != null && !alreadyBorrowed) {
                  final newBorrowedBook = BorrowedBook(
                    booktitle: selectedBookTitle.toString(),
                    memberName: memberNameController.text,
                    membercode: memberCodeController.text,
                    borrowedDate: DateTime.now(),
                    returnDate: DateTime.now().add(const Duration(days: 3)),
                  );

                  borrowedBookBox.add(newBorrowedBook);
                  try {
                    //make sure that copiesAvailable is not less than 2

                    book.copiesAvailable -= 1;

                    await books.put(book.bookid, book);
                  } catch (e) {
                    // Handle the case where the book is not found
                    print('Book not found');
                  }

                  setState(() {});

                  Navigator.pop(context, newBorrowedBook);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: alreadyBorrowed
                          ? Text('This member has already borrowed a book.')
                          : Text('The book or the member does not exist.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  color:
                      Theme.of(context).textTheme.button?.color ?? Colors.black,
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
                  color:
                      Theme.of(context).textTheme.button?.color ?? Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
