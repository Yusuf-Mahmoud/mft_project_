import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mft_final_project/Tabs/Members/memberbuttonadd.dart';
import 'package:mft_final_project/module/member.dart';

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
              filterMembers(value);
            },
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
              child: Text('Code',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Gender',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Department',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Text('Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMembers.length,
            itemBuilder: (context, index) {
              final member = filteredMembers[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      '${member.Memberid}',
                    )),
                    Expanded(child: Text('${member.Membercode}')),
                    Expanded(child: Text('${member.Membername}')),
                    Expanded(child: Text('${member.Gender}')),
                    Expanded(
                        child: Center(child: Text('${member.department}'))),
                    Expanded(child: Text('${member.Note}')),
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
                            builder: (context) => AddMember(member: member),
                          ),
                        ).then((updatedMember) {
                          if (updatedMember != null) {
                            setState(() {
                              membersBox.put(
                                  updatedMember.Memberid, updatedMember);

                              int index = members.indexWhere(
                                  (m) => m.Memberid == updatedMember.Memberid);

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
            'Add Member',
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
