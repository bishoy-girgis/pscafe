import 'package:intl/intl.dart';

class MyDatetimeUtilies{
  static String formateDate (DateTime dateTime){
    DateFormat formater =DateFormat("dd/MMM/yyyy");
    return formater.format(dateTime);
  }
  static String formateTime (DateTime dateTime){
    DateFormat formater =DateFormat.jm();
    return formater.format(dateTime);
  }
}//String datetime2 = DateFormat.Hms().format(datetime);
