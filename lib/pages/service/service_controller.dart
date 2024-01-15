import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController extends GetxController {
  RxString serviceName = ''.obs;

  void setServiceName(String name) {
    serviceName.value = name;
  }
}

class PreferencesController extends GetxController {
  final RxString username = ''.obs;

  Future<void> saveUsername(String name) async {
    SharedPreferences prefs = await Get.find();
    await prefs.setString('username', name);
    username.value = name;
  }

  Future<void> loadUsername() async {
    SharedPreferences prefs = await Get.find();
    username.value = prefs.getString('username') ?? '';
  }
}
