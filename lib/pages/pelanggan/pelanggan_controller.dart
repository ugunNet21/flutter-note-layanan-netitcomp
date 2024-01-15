import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_layanan_netitcomp/models/data_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PelangganController extends GetxController {
  RxList<Pelanggan> pelangganList = <Pelanggan>[].obs;
  static const String pelangganKey = 'pelangganKey';
  Future<void> savePelangganToPrefs() async {
    try {
      final prefs = Get.find<SharedPreferences>();
      final pelangganJsonList =
          pelangganList.map((pelanggan) => pelanggan.toJson()).toList();
      await prefs.setString(pelangganKey, json.encode(pelangganJsonList));
      print('Data pelanggan berhasil disimpan di SharedPreferences.');
    } catch (e) {
      print('Error saat menyimpan data pelanggan: $e');
    }
  }

  Future<void> loadPelangganFromPrefs() async {
    try {
      final prefs = Get.find<SharedPreferences>();
      final pelangganJsonString = prefs.getString(pelangganKey);
      if (pelangganJsonString != null && pelangganJsonString.isNotEmpty) {
        final List<dynamic> pelangganJsonList =
            json.decode(pelangganJsonString);
        pelangganList.assignAll(
            pelangganJsonList.map((json) => Pelanggan.fromJson(json)).toList());
        print('Data pelanggan berhasil dimuat dari SharedPreferences.');
      }
    } catch (e) {
      print('Error saat memuat data pelanggan: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Memuat data pelanggan ketika controller diinisialisasi
    loadPelangganFromPrefs();
  }

  Future<void> initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs, permanent: true);

    final pelangganController =
        Get.put<PelangganController>(PelangganController());
    await pelangganController.loadPelangganFromPrefs();
  }

  // Metode untuk menampilkan detail pelanggan
  void showPelangganDetail(BuildContext context, Pelanggan pelanggan) {
    Get.defaultDialog(
      title: 'Detail Pelanggan',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama: ${pelanggan.namaPelanggan}'),
          Text('Alamat: ${pelanggan.alamat}'),
          Text('Nomor Telepon: ${pelanggan.nomorTelepon}'),
          Text('Email: ${pelanggan.email}'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Tampilkan form edit pelanggan
            showEditForm(pelanggan);
          },
          child: const Text('Edit'),
        ),
        ElevatedButton(
          onPressed: () {
            // Fungsi cetak data pelanggan
            printPelangganData(pelanggan);
          },
          child: const Text('Cetak'),
        ),
        ElevatedButton(
          onPressed: () {
            // Fungsi berbagi data pelanggan
            sharePelangganData(pelanggan);
          },
          child: const Text('Bagikan'),
        ),
      ],
    );
  }

  void printPelangganData(Pelanggan pelanggan) {
    print('Data pelanggan dicetak: ${pelanggan.toJson()}');
  }

  void sharePelangganData(Pelanggan pelanggan) {
    print('Data pelanggan dibagikan: ${pelanggan.toJson()}');
    final message =
        'Nama: ${pelanggan.namaPelanggan}\nAlamat: ${pelanggan.alamat}\nNomor Telepon: ${pelanggan.nomorTelepon}\nEmail: ${pelanggan.email}';

    Share.share(message);
  }

  void showEditForm(Pelanggan pelanggan) {
    debugPrint('Data pelanggan diedit: ${pelanggan.toJson()}');
  }

  void addPelanggan(
      String nama, String alamat, String nomorTelepon, String email) {
    pelangganList.add(
      Pelanggan(
        idPelanggan: pelangganList.length +
            1, // Contoh: ID bisa dihasilkan sesuai kebutuhan aplikasi Anda
        namaPelanggan: nama,
        alamat: alamat,
        nomorTelepon: nomorTelepon,
        email: email,
      ),
    );
    savePelangganToPrefs();
  }

  // Metode untuk mengedit data pelanggan
  void editPelanggan(Pelanggan pelanggan, String nama, String alamat,
      String nomorTelepon, String email) {
    int index =
        pelangganList.indexWhere((p) => p.idPelanggan == pelanggan.idPelanggan);
    if (index != -1) {
      final oldPelanggan = fromPelanggan(pelanggan);
      pelangganList[index] = Pelanggan(
        idPelanggan: pelanggan.idPelanggan,
        namaPelanggan: nama,
        alamat: alamat,
        nomorTelepon: nomorTelepon,
        email: email,
      );
      // Hapus dari SharedPreferences setelah mengedit
      savePelangganToPrefs();
      // Cetak pesan berhasil mengedit
      print('Data pelanggan berhasil diubah: $oldPelanggan menjadi $pelanggan');
    } else {
      print('Error: Pelanggan tidak ditemukan.');
    }
  }

  // Metode untuk menghapus pelanggan
  void removePelanggan(Pelanggan pelanggan) {
    pelangganList.remove(pelanggan);
    // Hapus dari SharedPreferences setelah menghapus
    savePelangganToPrefs();
    // Cetak pesan berhasil menghapus
    print('Data pelanggan berhasil dihapus: $pelanggan');
  }

  // Metode untuk menandai atau tidak menandai pelanggan
  void toggleSelected(Pelanggan pelanggan) {
    pelanggan.isSelected = !pelanggan.isSelected;
  }

  // Metode untuk mengecek apakah pelanggan ditandai atau tidak
  bool isSelected(Pelanggan pelanggan) {
    return pelanggan.isSelected;
  }

  Pelanggan fromPelanggan(Pelanggan pelanggan) {
    return Pelanggan(
      idPelanggan: pelanggan.idPelanggan,
      namaPelanggan: pelanggan.namaPelanggan,
      alamat: pelanggan.alamat,
      nomorTelepon: pelanggan.nomorTelepon,
      email: pelanggan.email,
      isSelected: pelanggan.isSelected,
    );
  }

  // Fungsi untuk menyimpan data pelanggan ke SharedPreferences saat ada perubahan
  @override
  void onClose() {
    super.onClose();
    savePelangganToPrefs();
  }
}
