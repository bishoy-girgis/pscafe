import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps_system/model/room_model.dart';
import 'package:ps_system/provider/manage_rooms_provider.dart';
import 'package:ps_system/shared_components/constants.dart';

class AddPsBottomSheet extends StatefulWidget {
  double? price;

  AddPsBottomSheet({this.price});
  
  @override
  State<AddPsBottomSheet> createState() => _AddPsBottomSheetState();
}

class _AddPsBottomSheetState extends State<AddPsBottomSheet> {
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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

  @override
  Widget build(BuildContext context) {
    var manageroomsProvider = Provider.of<ManageRoomsProvider>(context);

    return Form(
      key: formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Add PLayStation",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 50),
            DropdownButtonFormField<String>(
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Please select the room";
                }
              },
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
                fillColor: pagee,
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
            const SizedBox(height: 50),
            Row(children: [
              Text(
                "Select Type :",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 200,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: selectedTypeTime == "Single"
                        ? primaryColor
                        : Colors.white),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTypeTime = "Single";
                    });
                  },
                  child: Text(
                    "Single",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: selectedTypeTime == "Single"
                            ? Colors.white
                            : primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: selectedTypeTime == "Multi"
                        ? primaryColor
                        : Colors.white),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTypeTime = "Multi";
                    });
                  },
                  child: Text(
                    "Multi",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: selectedTypeTime == "Multi"
                            ? Colors.white
                            : primaryColor),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 80,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                ),
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  validation();
                  RoomModel room = RoomModel(
                      teamName: selectedRoom!,
                      type: selectedTypeTime!,
                      price:widget.price,
                      startTime: startTime);
                  manageroomsProvider.addRoom(room);
                },
                label: Text(
                  "Start Time",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ]),
        ),
      ),
    );
  }

  DateTime startTime = DateTime.now();

  validation() {
    return {
      if (formKey.currentState!.validate())
        {
          if (selectedRoom != null)
            {
              if (selectedTypeTime == null)
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Validation Error"),
                        content: const Text(
                          "Please select the type (Single or Multi).",
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  )
                }
              else
                {formKey.currentState!.save(), Navigator.pop(context)}
            }
          else
            {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Validation Error"),
                    content: const Text(
                      "Please select the room.",
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              )
            }
        }
      else
        {
          setState(() {
            autovalidateMode = AutovalidateMode.always;
          })
        }
    };
  }
}
