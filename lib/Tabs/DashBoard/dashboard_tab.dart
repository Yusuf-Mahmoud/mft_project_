import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/Theme.dart';
import 'package:mft_final_project/module/books.dart';
import 'package:mft_final_project/module/borrowed_book.dart';
import 'package:mft_final_project/module/member.dart';

class DashBoardTab extends StatefulWidget {
  final List<Books> books;
  final List<Member> members;
  final List<BorrowedBook> borrowedBooks;

  DashBoardTab(
      {required this.books,
      required this.members,
      required this.borrowedBooks});

  @override
  State<DashBoardTab> createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> {
  var selectedDate = DateTime.now();
  int countOverdueBorrowers() {
    int count = 0;
    DateTime now = DateTime.now();
    for (var book in widget.borrowedBooks) {
      if (now.difference(book.borrowedDate).inDays > 3) {
        count++;
      }
    }
    return count;
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    List<String> trans = [
      AppLocalizations.of(context)!.hello,
      AppLocalizations.of(context)!.allbooks,
      AppLocalizations.of(context)!.allmembers,
      AppLocalizations.of(context)!.allissuedbooks,
      AppLocalizations.of(context)!.overduebooks,
    ];
    var dateFormat = DateFormat('MMM dd, yyyy | EEEE, hh:mm a ');
    int numberOfBooks = widget.books.length;
    int numberOfMembers = widget.members.length;
    int numberOfBorrowedBooks = widget.borrowedBooks.length;
    int numberOfOverdueBorrowers = countOverdueBorrowers();

    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(trans[0],
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: apptheme.primarycolor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                onTap: () async {
                  final dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 356)),
                    initialDate: DateTime.now(),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (dateTime != null) selectedDate = dateTime;
                },
                child: Text(dateFormat.format(DateTime.now()),
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 60,
                          height: 150,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: apptheme.primarycolor,
                                ),
                                child: Icon(Icons.menu_book_sharp,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${trans[1]} $numberOfBooks',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 539),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 70,
                          height: 150,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: apptheme.primarycolor,
                                ),
                                child: Icon(Icons.person_outline,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${trans[2]} $numberOfMembers',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3 - 50,
                      height: 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: apptheme.primarycolor,
                            ),
                            child: Icon(Icons.replay_outlined,
                                color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${trans[3]} $numberOfBorrowedBooks',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3 - 50,
                      height: 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: apptheme.primarycolor,
                            ),
                            child: Icon(Icons.warning_amber_outlined,
                                color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${trans[4]} $numberOfOverdueBorrowers',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
