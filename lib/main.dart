import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ps_system/Pages/home/home_page.dart';
import 'package:ps_system/model/room_model.dart';
import 'package:ps_system/provider/manage_rooms_provider.dart';
import 'package:ps_system/shared_components/constants.dart';
import 'package:ps_system/shared_components/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RoomModelAdapter());
  await Hive.openBox<RoomModel>(kRoomsBox);

  runApp(
    ChangeNotifierProvider(
        create: (context) => ManageRoomsProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Champion PS',
      theme: MyTheme.LightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
//el yom 3dd el mshareb elly b3tha wtmnha
// grd 3dd el mshareb w s3rha tol el yom w shahr sna
//

