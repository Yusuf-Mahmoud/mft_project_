import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:mft_final_project/Tabs/Members/memberbuttonadd.dart';
import 'package:mft_final_project/Theme.dart';
import 'package:mft_final_project/module/member.dart';

import '../../core/functions.dart';

class MembersTab extends StatefulWidget {
  final List<Member> members;

  MembersTab({required this.members});

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
  List<Member> members = [];
  List<Member> filteredMembers = [];
  final membersBox = Hive.box('members');
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    members = widget.members;
    filteredMembers = members;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1?.color;
    List<String> translatemember = [
      AppLocalizations.of(context)!.code,
      AppLocalizations.of(context)!.name,
      AppLocalizations.of(context)!.gender,
      AppLocalizations.of(context)!.department,
      AppLocalizations.of(context)!.note,
      AppLocalizations.of(context)!.actions,
      AppLocalizations.of(context)!.addmember,
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
                    filterMembers(value);
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
                                Tools().exportToCSVMembers(members, context);
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
                                Tools().exportToPDFMembers(members, context);
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
                  child: const Center(
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                      textAlign: TextAlign.center,
                      'ID',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                    textAlign: TextAlign.center,
                    translatemember[0],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 1,
                child: Text(
                    textAlign: TextAlign.center,
                    translatemember[1],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 1,
                child: Text(
                    textAlign: TextAlign.center,
                    translatemember[2],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    textAlign: TextAlign.center,
                    translatemember[3],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    textAlign: TextAlign.center,
                    translatemember[4],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 1,
                child: Text(
                    textAlign: TextAlign.center,
                    translatemember[5],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMembers.length,
            itemBuilder: (context, index) {
              final member = filteredMembers[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            '${member.Memberid}',
                            style: TextStyle(fontSize: 17, color: textColor),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          '${member.Membercode}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          '${member.Membername}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          '${member.Gender}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        )),
                    Expanded(
                        flex: 2,
                        child: Text(
                          textAlign: TextAlign.center,
                          '${member.department}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          textAlign: TextAlign.center,
                          '${member.Note}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        )),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              color: Colors.pink,
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddMember(member: member),
                                  ),
                                ).then((updatedMember) {
                                  if (updatedMember != null) {
                                    setState(() {
                                      membersBox.put(updatedMember.Memberid,
                                          updatedMember);

                                      int index = members.indexWhere((m) =>
                                          m.Memberid == updatedMember.Memberid);

                                      if (index != -1) {
                                        members[index] = updatedMember;
                                        filterMembers(searchController.text);
                                      }
                                    });
                                  }
                                });
                              },
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: const Icon(Icons.person_remove_alt_1),
                              onPressed: () {
                                setState(() {
                                  membersBox.delete(member.Memberid);
                                  members.removeAt(index);
                                  filterMembers(searchController.text);
                                });
                              },
                            ),
                          ],
                        )),
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
                    child: AddMember(),
                  ),
                );
              },
            ).then((newMember) {
              if (newMember != null) {
                setState(() {
                  members.add(newMember);
                  filterMembers(searchController.text);
                });
              }
            });
          },
          style: Theme.of(context).elevatedButtonTheme.style,
          child: Text(
            translatemember[6],
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

  void filterMembers(String query) {
    setState(() {
      filteredMembers = members.where((member) {
        return member.Memberid.toString().contains(query) ||
            member.Membercode.toLowerCase().contains(query.toLowerCase()) ||
            member.Membername.toLowerCase().contains(query.toLowerCase()) ||
            member.department.toLowerCase().contains(query.toLowerCase()) ||
            member.Note.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }
}
