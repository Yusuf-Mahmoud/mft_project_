import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mft_final_project/Tabs/Books/book_tab.dart';
import 'package:mft_final_project/Tabs/DashBoard/dashboard_tab.dart';
import 'package:mft_final_project/Tabs/Help/help_tab.dart';
import 'package:mft_final_project/Tabs/Members/members_tab.dart';
import 'package:mft_final_project/Tabs/isseudbook/isseud_book_tab.dart';
import 'package:mft_final_project/Tabs/settings/setting_tab.dart';
import 'package:mft_final_project/Theme.dart';
import 'package:mft_final_project/module/borrowed_book.dart';
import 'package:mft_final_project/module/member.dart';

import 'module/books.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Books> books = [];
  List<Member> members = [];
  List<BorrowedBook> borrowedBooks = [];
  final booksBox = Hive.box('books');
  final membersBox = Hive.box('members');
  final borrowedBookBox = Hive.box('borrowedBookBox'); // Correct variable name
  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    books = booksBox.values.cast<Books>().toList();
    members = membersBox.values.cast<Member>().toList();
    borrowedBooks = borrowedBookBox.values
        .cast<BorrowedBook>()
        .toList(); // Correct variable name

    tabs = [
      DashBoardTab(
          books: books, members: members, borrowedBooks: borrowedBooks),
      IsseudBook(),
      BookTab(books: books),
      MembersTab(members: members),
      SettingsTab(),
      HelpTab(),
    ];
  }

  PageController mody = PageController();

  int colorIndex = 0;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> appbartitles = [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.issuedbook,
      AppLocalizations.of(context)!.books,
      AppLocalizations.of(context)!.members,
      AppLocalizations.of(context)!.settings,
      AppLocalizations.of(context)!.info,
    ];
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/MFT-logo.png'),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appbartitles[selectedIndex])),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: mediaQuery.size.height,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            colorIndex = 0;
                            mody.jumpToPage(0);
                          },
                          icon: Icon(
                            Icons.dashboard,
                            color: colorIndex == 0
                                ? apptheme.primarycolor
                                : apptheme.unselectedcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            colorIndex = 1;
                            mody.jumpToPage(1);
                          },
                          icon: Icon(
                            Icons.replay_outlined,
                            color: colorIndex == 1
                                ? apptheme.primarycolor
                                : apptheme.unselectedcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            colorIndex = 2;
                            mody.jumpToPage(2);
                          },
                          icon: Icon(
                            Icons.menu_book_rounded,
                            color: colorIndex == 2
                                ? apptheme.primarycolor
                                : apptheme.unselectedcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            colorIndex = 3;
                            mody.jumpToPage(3);
                          },
                          icon: Icon(
                            Icons.person,
                            color: colorIndex == 3
                                ? apptheme.primarycolor
                                : apptheme.unselectedcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            colorIndex = 4;
                            mody.jumpToPage(4);
                          },
                          icon: Icon(
                            Icons.settings,
                            color: colorIndex == 4
                                ? apptheme.primarycolor
                                : apptheme.unselectedcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            colorIndex = 5;
                            mody.jumpToPage(5);
                          },
                          icon: Icon(
                            Icons.info_outline,
                            color: colorIndex == 5
                                ? apptheme.primarycolor
                                : apptheme.unselectedcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 95,
            child: PageView(
              //physics: const NeverScrollableScrollPhysics(),
              // scrollDirection: Axis.vertical,
              controller: mody,
              children: tabs.map((Widget tab) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: tab,
                );
              }).toList(),
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
