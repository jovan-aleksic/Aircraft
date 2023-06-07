
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsOfInternet {

  static Future<bool> checkInternetOfMobileConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    final sp = await SharedPreferences.getInstance();
    bool? wifi =  sp.getBool("wifi");
    if (connectivityResult == ConnectivityResult.mobile || wifi!) {
      return false;
    }else{
      return true;
    }

  }
}