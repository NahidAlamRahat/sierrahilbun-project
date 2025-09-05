import 'package:get/get.dart';
import 'package:sierrahilbun/widgets/app_snack_bar/app_snack_bar.dart';

class HomeController extends GetxController{
  DateTime ? lastBackPressTime;

  Future<bool> onWillPop() async{
    DateTime currentTime = DateTime.now();
    bool backButton = lastBackPressTime == null ||
        currentTime.difference(lastBackPressTime!) > const Duration(seconds: 2);
    if(backButton){
      lastBackPressTime=currentTime;
      AppSnackBar.message('Double click to exit app');
      return false;
    }
    return true;
  }
  


}