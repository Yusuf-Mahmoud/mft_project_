import 'package:hive/hive.dart';

part 'member.g.dart';

@HiveType(typeId: 1)
class Member extends HiveObject {
  @HiveField(0)
  int Memberid;

  @HiveField(1)
  String Membercode;

  @HiveField(2)
  String Membername;

  @HiveField(3)
  String Gender;

  @HiveField(4)
  String department;

  @HiveField(5)
  String Note;

  Member({
    required this.Memberid,
    required this.Membercode,
    required this.Membername,
    required this.Gender,
    required this.department,
    required this.Note,
  });

  Map<String, dynamic> toMap() {
    return {
      'Memberid': Memberid,
      'Membercode': Membercode,
      'Membername': Membername,
      'Gender': Gender,
      'department': department,
      'Note': Note,
    };
  }

  static Member fromMap(Map<String, dynamic> map) {
    return Member(
      Memberid: map['Memberid'],
      Membercode: map['Membercode'],
      Membername: map['Membername'],
      Gender: map['Gender'],
      department: map['department'],
      Note: map['Note'],
    );
  }
}

class MemberHive {
  final Box<Member> _memberBox;

  MemberHive(this._memberBox);

  Future<void> addMemberFromMap(Map<String, dynamic> map) async {
    await _memberBox.put(map['Memberid'], Member.fromMap(map));
  }

  Future<void> updateMemberFromMap(Map<String, dynamic> map) async {
    await _memberBox.put(map['Memberid'], Member.fromMap(map));
  }

  Future<void> deleteMember(int memberId) async {
    await _memberBox.delete(memberId);
  }

  Member? getMember(int memberId) {
    if (_memberBox.containsKey(memberId)) {
      return _memberBox.get(memberId);
    }
    return null;
  }

  Map<int, Member>? getAllMembers() {
    final memberMap = _memberBox.toMap();
    if (memberMap != null && memberMap.isNotEmpty) {
      return Map<int, Member>.from(memberMap);
    }
    return null;
  }
}
