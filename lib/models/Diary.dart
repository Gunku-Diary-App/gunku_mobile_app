import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Diary extends HiveObject {

  @HiveField(0)
  String date;

  @HiveField(1)
  String content;
  
}