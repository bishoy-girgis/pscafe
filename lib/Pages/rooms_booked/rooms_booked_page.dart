import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ps_system/provider/manage_rooms_provider.dart';

import 'widgets/grid_view_rooms.dart';

class RoomsBookedPage extends StatelessWidget {
  const RoomsBookedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var managerooms = Provider.of<ManageRoomsProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 15 / 5.5,
          crossAxisCount: 3,
          crossAxisSpacing: 80,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => GridViewRooms(roomModel: managerooms.fetchRooms()[index]),
        itemCount: managerooms.fetchRooms().length,
      ),
    );
  }
}
