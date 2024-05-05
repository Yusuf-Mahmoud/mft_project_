import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mft_final_project/module/member.dart';

class AddMember extends StatefulWidget {
  final Member? member;

  AddMember({this.member});

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController memberCodeController = TextEditingController();
  final TextEditingController memberNameController = TextEditingController();
  final TextEditingController GenderController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final membersBox = Hive.box('members');

  @override
  // بتعمل تحقق علي البيانات اللي انا بكتبها
  void initState() {
    super.initState();
    if (widget.member != null) {
      memberCodeController.text = widget.member!.Membercode;
      memberNameController.text = widget.member!.Membername;
      GenderController.text = widget.member!.Gender;
      departmentController.text = widget.member!.department;
      noteController.text = widget.member!.Note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: TextFormField(
                controller: memberCodeController,
                decoration: InputDecoration(labelText: 'Membercode'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a member code';
                  }
                  if (value[0] != 'M' && value[0] != 'D') {
                    return 'Member code must start with M or D';
                  }
                  if (value.substring(1).length != 7 ||
                      !RegExp(r'^\d+$').hasMatch(value.substring(1))) {
                    return 'Following characters must be 7 digits';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: TextFormField(
                controller: memberNameController,
                decoration: InputDecoration(labelText: 'Membername'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a member name';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: DropdownButtonFormField<String>(
                value: GenderController.text.isNotEmpty
                    ? GenderController.text
                    : null,
                decoration: InputDecoration(labelText: 'Gender'),
                items: <String>[
                  'male',
                  'female',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    GenderController.text = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: DropdownButtonFormField<String>(
                value: departmentController.text.isNotEmpty
                    ? departmentController.text
                    : null,
                decoration: InputDecoration(labelText: 'Department'),
                items: <String>[
                  'doctor',
                  'student',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    departmentController.text = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: TextFormField(
                controller: noteController,
                maxLength: 255,
                decoration: InputDecoration(labelText: 'Note'),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.member != null) {
                      setState(() {
                        widget.member!.Membercode = memberCodeController.text;
                        widget.member!.Membername = memberNameController.text;
                        widget.member!.Gender = GenderController.text;
                        widget.member!.department = departmentController.text;
                        widget.member!.Note = noteController.text;
                      });
                      Navigator.pop(context, widget.member);
                    } else {
                      bool isDuplicate = false;
                      for (var i = 0; i < membersBox.length; i++) {
                        Member existingMember = membersBox.getAt(i);
                        if (existingMember != null &&
                            existingMember.Membercode ==
                                memberCodeController.text) {
                          isDuplicate = true;
                          break;
                        }
                      }

                      if (isDuplicate) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(
                                'Member code already exists. Please choose a different one.',
                              ),
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
                        final newMember = Member(
                          Memberid: membersBox.length + 1,
                          Membercode: memberCodeController.text,
                          Membername: memberNameController.text,
                          Gender: GenderController.text,
                          department: departmentController.text,
                          Note: noteController.text,
                        );
                        membersBox.put(newMember.Memberid, newMember);
                        Navigator.pop(context, newMember);
                      }
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
    );
  }
}
