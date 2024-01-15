import 'package:flutter/material.dart';
import 'package:flutter_layanan_netitcomp/pages/home/home_screen.dart';
import 'package:flutter_layanan_netitcomp/pages/pelanggan/pelanggan_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  runApp(const MainApp());
}

Future<void> initSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs, permanent: true);

  final pelangganController = Get.put(PelangganController());
  await pelangganController.loadPelangganFromPrefs();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "GetX Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
