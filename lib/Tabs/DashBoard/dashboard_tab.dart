import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mft_final_project/Theme.dart';
import 'package:mft_final_project/module/books.dart';
import 'package:mft_final_project/module/member.dart';

class DashBoardTab extends StatefulWidget {
  final List<Books> books;
  final List<Member> members;
  

  DashBoardTab({required this.books, required this.members});

  @override
  State<DashBoardTab> createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<String> trans = [
      AppLocalizations.of(context)!.hello,
    ];
    var dateFormat = DateFormat('MMM dd, yyyy | EEEE, hh:mm a ');
    int numberOfBooks = widget.books.length;
    int numberOfMembers = widget.members.length;

    return Container(
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
                          color: const Color(0xffffffff),
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
                              'Number of Books: $numberOfBooks',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                          color: const Color(0xffffffff),
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
                              'Number of Members: $numberOfMembers',
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
        ],
      ),
    );
  }
}
