
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:ps_system/shared_components/constants.dart';

import '../../../model/room_model.dart';
import '../../../provider/manage_rooms_provider.dart';
import '../../../utilies/mydatetime_utilies.dart';

class GridViewFinishedRooms extends StatefulWidget {
  final RoomModel roomModel;

  const GridViewFinishedRooms({super.key, required this.roomModel});

  @override
  State<GridViewFinishedRooms> createState() => _GridViewFinishedRoomsState();
}

class _GridViewFinishedRoomsState extends State<GridViewFinishedRooms> {
  @override
  Widget build(BuildContext context) {
    var managerooms = Provider.of<ManageRoomsProvider>(context);
    var mw = MediaQuery.of(context).size.width ;
    var mh = MediaQuery.of(context).size.height ;
    var theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Slidable(
          startActionPane:
              ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                managerooms.deleteRoom(widget.roomModel.startTime);
              },
              icon: Icons.delete,
              label: "Delete",
              backgroundColor: Color(0XFFB33030),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
            ),
          ]),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
             SizedBox(
              width:mw *  0.01,
            ),
            Container(
              width: mw * 0.008,
              height: mh*0.12,
              decoration: BoxDecoration(
                  color: pagee, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.roomModel.teamName,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.roomModel.type,
                    style: theme.textTheme.bodySmall,
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
                      Text(MyDatetimeUtilies.formateTime(widget.roomModel.startTime),
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.roomModel.drinks != null && widget.roomModel.numberDrink!.isNotEmpty
                            ? '${widget.roomModel.numberDrink! .join(", ")} \n ${widget.roomModel.drinks!.join(", ")}'
                            : "No Drinks",
                        style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                      ),
                      Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: pagee),
                          child: Text(
                            "${widget.roomModel.price.toString()} EGP",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: primaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => _buildDetailsDialog());
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 60,
                  child: widget.roomModel.teamName == "zamalek" ||
                          widget.roomModel.teamName == "ahly"
                      ? FractionallySizedBox(
                          widthFactor: 1.8,
                          heightFactor: 1.8,
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
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
              ),
            ),
          ]),
        ));
  }
  Widget _buildDetailsDialog() {
    var managerooms = Provider.of<ManageRoomsProvider>(context as BuildContext);
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
      title: Text("Details",
          style: Theme.of(context as BuildContext)
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
              style: Theme.of(context as BuildContext)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Start Time : ${MyDatetimeUtilies.formateTime(widget.roomModel.startTime)}",
              style: Theme.of(context as BuildContext)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            // Text(
            //   "End Time : ${MyDatetimeUtilies.formateTime(DateTime.now())}",
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyMedium
            //       ?.copyWith(color: primaryColor),
            // ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Type : ${widget.roomModel.type}",
              style: Theme.of(context as BuildContext)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Drinks : '${widget.roomModel.numberDrink}=>${{widget.roomModel.drinks}.join(", ")} ",
              style: Theme.of(context as BuildContext)
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
                "Total = ${widget.roomModel.price} EGP",
                style: Theme.of(context as BuildContext).textTheme.headlineMedium,
              ),
            ),  //total cost
          ],
        ),
      ),
      actions: [
        ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(pagee),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
              alignment: Alignment.center),
          icon: const Icon(CupertinoIcons.checkmark_alt, color: primaryColor),
          onPressed: () {
            Navigator.of(context as BuildContext).pop(); // Close the dialog
          },
          label: Text('ok',
              style: Theme.of(context as BuildContext)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor)),
        ),
      ],
    );
  }


}
