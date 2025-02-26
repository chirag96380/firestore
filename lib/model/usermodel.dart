import 'package:hive/hive.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String age;

  @HiveField(3)
  String location;

  User(
      {required this.id,
      required this.name,
      required this.age,
      required this.location});
}
