import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_wallpaper/localization/language.dart';


void copyWidget(context){
  final language=Provider.of<Language>(context,listen:false);
  Fluttertoast.showToast(
      msg: language.words['copy'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.green,
      textColor: AppTheme.white,
      fontSize: 16.0);
}
