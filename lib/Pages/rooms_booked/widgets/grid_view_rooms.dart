import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinbox/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ps_system/Pages/rooms_booked/rooms_booked_page.dart';
import 'package:ps_system/Pages/rooms_booked/widgets/add_ps_bottom_sheet.dart';
import 'package:ps_system/model/room_model.dart';
import 'package:ps_system/shared_components/constants.dart';
import 'package:ps_system/utilies/mydatetime_utilies.dart';

import '../../../provider/manage_rooms_provider.dart';

class GridViewRooms extends StatefulWidget {
  final RoomModel roomModel;

  const GridViewRooms({super.key, required this.roomModel});

  @override
  State<GridViewRooms> createState() => _GridViewRoomsState();
}

class _GridViewRoomsState extends State<GridViewRooms> {
  List<String> selectedDrinks = [];
  List<double> numberOfDrinks = [];
  double _selectValue = 0;
  String selectedDrink = "";

  @override
  Widget build(BuildContext context) {
    var managerooms = Provider.of<ManageRoomsProvider>(context);

    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Slidable(
        startActionPane:
            ActionPane(extentRatio: 0.15, motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              managerooms.deleteRoom(widget.roomModel.startTime);
            },
            icon: Icons.delete,
            label: "Delete",
            backgroundColor: Color(0XFFB33030),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
          ),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 8,
              height: 100,
              decoration: BoxDecoration(
                  color: pagee, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 100,
                      ),
                      Text(widget.roomModel.teamName,
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontSize: 25)),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: pagee,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                          MyDatetimeUtilies.formateTime(
                              widget.roomModel.startTime),
                          style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.person_2,
                        color: pagee,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(widget.roomModel.type,
                          style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.coffee,
                        color: pagee,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.roomModel.drinks != null && widget.roomModel.numberDrink!.isNotEmpty
                            ? '${widget.roomModel.numberDrink!.join(", ")} : ${widget.roomModel.drinks!.join(", ")}'
                            : "No Drinks",
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                      ),

                      const SizedBox(width: 8),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 100,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => _buildDrinkDialog());

                          },
                          icon: const Icon(Icons.coffee, color: primaryColor),
                          label: Text("Add drink",
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: primaryColor)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(pagee),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => _builfFinishDialog());
                          },
                          icon: const Icon(CupertinoIcons.check_mark_circled,
                              color: primaryColor),
                          label: Text("Finished",
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: primaryColor)),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0XFFA2FF86)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                managerooms.fetchRooms();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 60,
                  child: widget.roomModel.teamName == "zamalek" ||
                          widget.roomModel.teamName == "ahly"
                      ? FractionallySizedBox(
                          widthFactor: 2,
                          heightFactor: 2,
                          child: Image.asset(
                            'assets/images/${widget.roomModel.teamName}.png',
                            // Replace with the actual path of your Barcelona logo image
                            fit: BoxFit.contain,
                          ),
                        )
                      : FractionallySizedBox(
                          widthFactor: 3.6,
                          heightFactor: 3.6,
                          child: Image.asset(
                            'assets/images/${widget.roomModel.teamName}.png',
                            // Replace with the actual path of your Barcelona logo image
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrinkDialog() {
    // elevated buttons lma ados 3lehom ye add in list drink
    var theme = Theme.of(context);
    var managerooms = Provider.of<ManageRoomsProvider>(context);


    return AlertDialog(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text(
        'Choose Drink',
        style:
            Theme.of(context).textTheme.headlineMedium?.copyWith(color: pagee),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: pagee),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDrink = "tea";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            selectedDrink == "tea" ? primaryColor : second),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      "Tea",
                      style: selectedDrink == "tea"
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.displayLarge,
                    )),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDrink = "coffee";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            selectedDrink == "coffee" ? primaryColor : second),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      "Coffee",
                      style: selectedDrink == "coffee"
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.displayLarge,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDrink = "nescafe";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            selectedDrink == "nescafe" ? primaryColor : second),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      "Nescafe",
                      style: selectedDrink == "nescafe"
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.displayLarge,
                    )),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDrink = "fayrouz";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            selectedDrink == "fayrouz" ? primaryColor : second),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      "Fayrouz",
                      style: selectedDrink == "fayrouz"
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.displayLarge,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDrink = "pepsi";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            selectedDrink == "pepsi" ? primaryColor : second),
                        padding: const MaterialStatePropertyAll(EdgeInsets.all(6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      "Pepsi",
                      style: selectedDrink == "pepsi"
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.displayLarge,
                    )),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDrink = "seven";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            selectedDrink == "seven" ? primaryColor : second),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      "7UP",
                      style: selectedDrink == "seven"
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.displayLarge,
                    )),
              ],
            ),
            const SizedBox(
              height: 180,
            ),
            CupertinoSpinBox(
              min: 0,
              max: 20,
              value: _selectValue,
              onChanged: (value) => _selectValue = value,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: primaryColor),
              padding: EdgeInsets.all(15),
              cursorColor: pagee,
              textAlign: TextAlign.center,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: pagee),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(pagee)),
          onPressed: ()  {
            numberOfDrinks.add(_selectValue);
            selectedDrinks.add(selectedDrink);

            selectedDrink = "";
            Navigator.of(context).pop(); // Close the dialog

            setState(() {
              managerooms.addDrinkRoom(widget.roomModel.startTime, selectedDrinks, numberOfDrinks);

            });

            print('Selected Drinks: ${widget.roomModel.drinks}');
            print('Number of Drinks: ${widget.roomModel.numberDrink}');
          },
          child: Text('Add',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor)),
        ),
      ],
    );
  }

  Widget _builfFinishDialog() {
    var managerooms = Provider.of<ManageRoomsProvider>(context);
    String? selectedTypeTime;
    String? selectedRoom;
    List<String> rooms = [
      'barcelona',
      'realmadrid',
      'ahly',
      'zamalek',
      'liverpool',
      'paris',
      'juve'
    ];
    return AlertDialog(
      backgroundColor: primaryColor,
      title: Text("Bill",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: pagee)),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: pagee),
        child: Column(
          children: [
            Text(
              "Room : ${widget.roomModel.teamName}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Start Time : ${MyDatetimeUtilies.formateTime(widget.roomModel.startTime)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "End Time : ${MyDatetimeUtilies.formateTime(DateTime.now())}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Type : ${widget.roomModel.type}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Drinks : '${widget.roomModel.numberDrink} : ${{widget.roomModel.drinks}.join(", ")} ",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),  // drinks
            const SizedBox(
              height: 80,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(25)),
              child: Text(
                "Total = ${CalculateTotalCost(widget.roomModel)} EGP",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),  //total cost
            SizedBox(height: 50,),
            Divider(color: primaryColor,height: 5,thickness: 2),
            SizedBox(height: 30,),
            Text("Go to another Room",style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: primaryColor)),
            SizedBox(height: 20,),
            DropdownButtonFormField<String>(
              value: selectedRoom,
              dropdownColor: Colors.white,
              iconSize: 20,
              onChanged: (String? newValue) {
                setState(() {
                  selectedRoom = newValue ?? "";
                });
              },
              decoration: InputDecoration(
                labelText: 'Select The Room',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: primaryColor),
                fillColor: second,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              items: rooms.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Row(children: [
              Text(
                "Select Type :",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: primaryColor),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: primaryColor),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTypeTime = "Single";
                    });
                  },
                  child: Text(
                    "Single",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: pagee),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: primaryColor),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTypeTime = "Multi";
                    });
                  },
                  child: Text(
                    "Multi",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: pagee),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(pagee),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(5)),
              alignment: Alignment.center),
          onPressed: () {
            CalculateTotalCost(widget.roomModel);
            managerooms.addRoom(RoomModel(
                teamName: selectedRoom!,
                type: selectedTypeTime!,
                price:CalculateTotalCost(widget.roomModel),
                startTime: DateTime.now()));
            managerooms.deleteRoom(widget.roomModel.startTime);
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Go to another Room',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor)),
        ),
        const SizedBox(width: 50,),
        ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(pagee),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
              alignment: Alignment.center),
          icon: const Icon(CupertinoIcons.money_dollar, color: primaryColor),
          onPressed: () {
            print('cost = ${CalculateTotalCost(widget.roomModel)}');
            managerooms.updateRoomFinishStatus(widget.roomModel.startTime,
                CalculateTotalCost(widget.roomModel));
            print;
            ("isfinish : ${widget.roomModel.isFinish.toString()}");
            Navigator.of(context).pop(); // Close the dialog
          },
          label: Text('Paid',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor)),
        ),
      ],
    );
  }

  CalculateTotalCost(RoomModel roomModel)   {
    Map<String, double> drinkPrices = {
      'tea': 4,
      'coffee': 8,
      'pepsi': 10,
      'nescafe': 10,
      'fayrouz': 10,
      'seven':10,
    };

    if (roomModel.type == "Single") {
      DateTime now = DateTime.now();
      Duration timeDifference = now.difference(roomModel.startTime);
      int hours = timeDifference.inHours;
      int minutes = timeDifference.inMinutes.remainder(60);
      double cost = (hours * 12) + (minutes * 12 / 60);
      if(roomModel.price!=null){
        cost = cost + roomModel.price!;
      }
      if(roomModel.numberDrink!=null&& roomModel.drinks!=null){
        for (int i = 0; i < roomModel.drinks!.length; i++) {
          String drink = roomModel.drinks![i];
          double quantity = roomModel.numberDrink![i];
          if (drinkPrices.containsKey(drink)) {
            double? price = drinkPrices[drink];
            cost += quantity * price!;
          }
        }
      }
      int roundedCost = cost.ceil();
      if (roundedCost < cost) {
        roundedCost++;
      }
      return roundedCost.toDouble();
    } else if (roomModel.type == "Multi") {
      DateTime now = DateTime.now();
      Duration timeDifference = now.difference(roomModel.startTime);
      int hours = timeDifference.inHours;
      int minutes = timeDifference.inMinutes.remainder(60);
      double cost = (hours * 20) + (minutes * 20 / 60);
      if(roomModel.price!=null){
        cost = cost + roomModel.price!;
      }
      if(roomModel.numberDrink!=null&& roomModel.drinks!=null){
        for (int i = 0; i < roomModel.drinks!.length; i++) {
          String drink = roomModel.drinks![i];
          double quantity = roomModel.numberDrink![i];
          if (drinkPrices.containsKey(drink)) {
            double? price = drinkPrices[drink];
            cost += quantity * price!;
          }
        }
      }
      int roundedCost = cost.ceil();
      if (roundedCost < cost) {
        roundedCost++;
      }
      return roundedCost.toDouble();
    }
  }

}
