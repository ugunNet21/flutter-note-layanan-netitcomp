import 'package:flutter/material.dart';
import 'package:flutter_layanan_netitcomp/pages/pelanggan/pelanggan_controller.dart';
import 'package:flutter_layanan_netitcomp/pages/pelanggan/pelanggan_list_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class HomeScreen extends StatelessWidget {
  final PelangganController pelangganController =
      Get.put(PelangganController());
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Net IT Comp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Tampilkan form input
                _showInputForm(context);
              },
              child: const Text('Tambah Pelanggan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tampilkan list pelanggan
                _showPelangganList(context);
              },
              child: const Text('Lihat Pelanggan'),
            ),
            const SizedBox(height: 20),
            // Gunakan Obx di sini
            Obx(() {
              return Text(
                'Jumlah Pelanggan: ${pelangganController.pelangganList.length}',
                style: TextStyle(fontSize: 16),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showInputForm(BuildContext context) {
    namaController.text = '';
    alamatController.text = '';
    nomorTeleponController.text = '';
    emailController.text = '';
    Get.defaultDialog(
      title: 'Tambah Pelanggan',
      content: Column(
        children: [
          TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Pelanggan')),
          TextField(
              controller: alamatController,
              decoration: const InputDecoration(labelText: 'Alamat')),
          TextField(
              controller: nomorTeleponController,
              decoration: const InputDecoration(labelText: 'Nomor Telepon')),
          TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Simpan data pelanggan
              pelangganController.addPelanggan(
                namaController.text,
                alamatController.text,
                nomorTeleponController.text,
                emailController.text,
              );
              Get.back(); // Tutup dialog setelah penyimpanan
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showPelangganList(BuildContext context) {
    Get.to(() => PelangganListScreen()); // Navigasi ke halaman list pelanggan
  }
}
