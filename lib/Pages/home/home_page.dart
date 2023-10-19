import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ps_system/Pages/rooms_booked/widgets/add_ps_bottom_sheet.dart';
import 'package:ps_system/shared_components/constants.dart';

import '../rooms_booked/rooms_booked_page.dart';
import '../rooms_finished/rooms_finished_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "home screen";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSelectedIndex = 0;
  List<Widget> screens = [RoomsBookedPage(), RoomsFinishPage()];

  @override
  Widget build(BuildContext context) {
    var mw = MediaQuery.of(context).size.width ;
    var mh = MediaQuery.of(context).size.height ;
    return Scaffold(
      // backgroundColor: pagee,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
               children: [
                  ImageIcon(AssetImage("assets/images/ball.png"),size: 220,),
                 Text("CHAMPION PlayStation ",
                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
               ],
             ),
            currentSelectedIndex == 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: ElevatedButton.icon(
                      icon: ImageIcon(AssetImage("assets/images/psc.png"),size: 55,color: primaryColor),
                      label: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Add PS",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                      ),
                      onPressed: () {
                        showAddPsBottomSheet();
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(pagee),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/chleague.png"),fit: BoxFit.cover)),
          child: screens[currentSelectedIndex]),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                currentSelectedIndex = index;
              });
            },
            currentIndex: currentSelectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 22,
                  ),
                  label: "HOME"),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/ps.png"),size: 30,),
                  label: "FINISH"),
            ]),
      ),
    );
  }

  showAddPsBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddPsBottomSheet(),
    );
  }
}
