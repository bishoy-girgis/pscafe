import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ps_system/shared_components/constants.dart';
import '../model/room_model.dart';

class ManageRoomsProvider extends ChangeNotifier{

  addRoom(RoomModel room) async {
    var roomsBox = Hive.box<RoomModel>(kRoomsBox);
    await roomsBox.add(room);
    notifyListeners();
  }

  fetchRooms() {
    var roomsBox = Hive.box<RoomModel>(kRoomsBox);
    List<RoomModel> rooms = roomsBox.values.toList();
    return rooms.where((element) => !element.isFinish).toList();
  }

  void updateRoomFinishStatus(DateTime time,double value) async {
    var roomsBox = Hive.box<RoomModel>(kRoomsBox);
    RoomModel? room = roomsBox.values.firstWhere(
          (element) => element.startTime == time,
    );

    if (room != null) {
      room.isFinish = true;
      room.price = value;
      await room.save();
      notifyListeners();
    }
  }

  void deleteRoom(DateTime time) async {
    var roomsBox = Hive.box<RoomModel>(kRoomsBox);
    List<RoomModel> matchingRooms = roomsBox.values.where((element) => element.startTime == time).toList();

    for (var room in matchingRooms) {
      await room.delete();
    }

    notifyListeners();
  }

  List<RoomModel> fetchRoomsByDateTime(DateTime dateTime, {bool isFinish = false}) {
    var roomsBox = Hive.box<RoomModel>(kRoomsBox);
    List<RoomModel> rooms = roomsBox.values.toList();

    List<RoomModel> filteredRooms = rooms.where((room) {
      return room.startTime.year == dateTime.year &&
          room.startTime.month == dateTime.month &&
          room.startTime.day == dateTime.day &&
          room.isFinish == isFinish;
    }).toList();

    return filteredRooms;
  }

  void addDrinkRoom(DateTime time, List<String> drinks, List<double> numberDrinks) async {
    var roomsBox = Hive.box<RoomModel>(kRoomsBox);
    RoomModel? room = roomsBox.values.firstWhere(
          (element) => element.startTime == time,
    );

    room.drinks = drinks;
    room.numberDrink = numberDrinks;
    await room.save();
    notifyListeners();
    print(room.drinks);
    print(room.numberDrink);
  }

  double calculateTotalPrice(List<RoomModel> rooms) {
    double totalPrice = 0;
    for (var room in rooms) {
      totalPrice += room.price!;
    }
    return totalPrice;
  }



}