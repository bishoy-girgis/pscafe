import 'package:hive_flutter/hive_flutter.dart';

part 'room_model.g.dart';

@HiveType(typeId: 0)
class RoomModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String teamName;
  @HiveField(2)
  String type;
  @HiveField(3)
  DateTime startTime;
  @HiveField(4)
  bool isFinish;
  @HiveField(5)
  double? price;
  @HiveField(6)
  List<String>? drinks;
  @HiveField(7)
  List<double>? numberDrink;

  RoomModel({
    this.id = "",
    required this.teamName,
    required this.type,
    required this.startTime,
    this.price,
    this.isFinish = false,
    this.drinks,
    this.numberDrink,
  });
}
