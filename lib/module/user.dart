import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  User({required this.username, required this.password});
}
