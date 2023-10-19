import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps_system/Pages/rooms_finished/widgets/grid_view_finished_rooms.dart';
import '../../provider/manage_rooms_provider.dart';
import '../../shared_components/constants.dart';

class RoomsFinishPage extends StatefulWidget {
  @override
  State<RoomsFinishPage> createState() => _RoomsFinishPageState();
}

class _RoomsFinishPageState extends State<RoomsFinishPage> {
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;

    var managerooms = Provider.of<ManageRoomsProvider>(context);

    return Column(
      children: [
        CalendarAgenda(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = DateUtils.dateOnly(date);
            setState(() {});
          },
          backgroundColor: primaryColor,
          selectedDateColor: primaryColor,
          dateColor: Colors.white,
          calendarEventSelectedColor: Colors.white,
          appbar: false,
          fullCalendar: true,
        ),
        // const SizedBox(
        //   height: 20,
        // ),
         SizedBox(
          height: mediaquery.height*0.02,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 60,
                childAspectRatio: 15 / 6),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(10),
              child: GridViewFinishedRooms(
                  roomModel: managerooms.fetchRoomsByDateTime(selectedDate,
                      isFinish: true)[index]),
            ),
            itemCount: managerooms
                .fetchRoomsByDateTime(selectedDate, isFinish: true)
                .length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: primaryColor,width: 2),color: second),
              child: Text(
                  'Total Price: \$${managerooms.calculateTotalPrice(managerooms.fetchRoomsByDateTime(selectedDate, isFinish: true)).toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: primaryColor)),
            ),
            // Container(
            //   padding: EdgeInsets.all(5),
            //   margin: EdgeInsets.symmetric(vertical: 5),
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: primaryColor,width: 2),color: second),
            //   child: Text(
            //       'Total Drinks: ',
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyMedium
            //           ?.copyWith(color: primaryColor)),
            // ),
          ],
        ),
                   // {2,3}       {pepsi , coffee}
                         // {1,2}         {tea , pepsi}
      ],
    );
  }
}
