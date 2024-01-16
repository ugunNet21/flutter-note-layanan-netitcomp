import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_layanan_netitcomp/models/data_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PelangganController extends GetxController {
  final TextEditingController editNamaController = TextEditingController();
  final TextEditingController editAlamatController = TextEditingController();
  final TextEditingController editNomorTeleponController =
      TextEditingController();
  final TextEditingController editEmailController = TextEditingController();
  RxList<Pelanggan> pelangganList = <Pelanggan>[].obs;
  static const String pelangganKey = 'pelangganKey';
  Future<void> savePelangganToPrefs() async {
    try {
      final prefs = Get.find<SharedPreferences>();
      final pelangganJsonList =
          pelangganList.map((pelanggan) => pelanggan.toJson()).toList();
      await prefs.setString(pelangganKey, json.encode(pelangganJsonList));
      debugPrint('Data pelanggan berhasil disimpan di SharedPreferences.');
    } catch (e) {
      debugPrint('Error saat menyimpan data pelanggan: $e');
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
        debugPrint('Data pelanggan berhasil dimuat dari SharedPreferences.');
      }
    } catch (e) {
      debugPrint('Error saat memuat data pelanggan: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadPelangganFromPrefs();
  }

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
            // showEditForm(pelanggan);
            // pelangganController.showEditForm(pelanggan);
            showEditForm(context, pelanggan);
          },
          child: const Text('Edit'),
        ),
        ElevatedButton(
          onPressed: () {
            printPelangganData(pelanggan);
          },
          child: const Text('Cetak'),
        ),
        ElevatedButton(
          onPressed: () {
            sharePelangganData(pelanggan);
          },
          child: const Text('Bagikan'),
        ),
      ],
    );
  }

  void printPelangganData(Pelanggan pelanggan) {
    debugPrint('Data pelanggan dicetak: ${pelanggan.toJson()}');
  }

  void sharePelangganData(Pelanggan pelanggan) {
    debugPrint('Data pelanggan dibagikan: ${pelanggan.toJson()}');
    final message =
        'Nama: ${pelanggan.namaPelanggan}\nAlamat: ${pelanggan.alamat}\nNomor Telepon: ${pelanggan.nomorTelepon}\nEmail: ${pelanggan.email}';

    Share.share(message);
  }

  void showEditForm(BuildContext context, Pelanggan pelanggan) {
    debugPrint('Data pelanggan diedit: ${pelanggan.toJson()}');
    editNamaController.text = pelanggan.namaPelanggan;
    editAlamatController.text = pelanggan.alamat;
    editNomorTeleponController.text = pelanggan.nomorTelepon;
    editEmailController.text = pelanggan.email;
    Get.defaultDialog(
      title: 'Edit Pelanggan',
      content: Column(
        children: [
          TextField(
            controller: editNamaController,
            decoration: const InputDecoration(labelText: 'Nama Pelanggan'),
          ),
          TextField(
            controller: editAlamatController,
            decoration: const InputDecoration(labelText: 'Alamat'),
          ),
          TextField(
            controller: editNomorTeleponController,
            decoration: const InputDecoration(labelText: 'Nomor Telepon'),
          ),
          TextField(
            controller: editEmailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              editPelanggan(
                pelanggan,
                editNamaController.text,
                editAlamatController.text,
                editNomorTeleponController.text,
                editEmailController.text,
              );
              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void addPelanggan(
      String nama, String alamat, String nomorTelepon, String email) {
    pelangganList.add(
      Pelanggan(
        idPelanggan: pelangganList.length + 1,
        namaPelanggan: nama,
        alamat: alamat,
        nomorTelepon: nomorTelepon,
        email: email,
      ),
    );
    savePelangganToPrefs();
  }

  void editPelanggan(Pelanggan pelanggan, String nama, String alamat,
      String nomorTelepon, String email) {
    try {
      // Cek apakah pelanggan ada dalam daftar
      int index = pelangganList.indexWhere(
        (p) => p.idPelanggan == pelanggan.idPelanggan,
      );

      if (index != -1) {
        // Simpan pelanggan sebelum diubah
        final oldPelanggan = fromPelanggan(pelanggan);

        // Edit data pelanggan
        pelangganList[index] = Pelanggan(
          idPelanggan: pelanggan.idPelanggan,
          namaPelanggan: nama,
          alamat: alamat,
          nomorTelepon: nomorTelepon,
          email: email,
        );

        // Simpan ke SharedPreferences setelah mengedit
        savePelangganToPrefs();

        // Cetak pesan berhasil mengedit
        debugPrint(
            'Data pelanggan berhasil diubah: $oldPelanggan menjadi $pelanggan');
      } else {
        // Tampilkan pesan jika pelanggan tidak ditemukan
        debugPrint('Error: Pelanggan tidak ditemukan.');
      }
    } catch (e) {
      // Tangkap dan tampilkan error jika ada
      debugPrint('Error saat mengedit data pelanggan: $e');
    }
  }

  void removePelanggan(Pelanggan pelanggan) {
    pelangganList.remove(pelanggan);

    savePelangganToPrefs();

    debugPrint('Data pelanggan berhasil dihapus: $pelanggan');
  }

  void toggleSelected(Pelanggan pelanggan) {
    pelanggan.isSelected = !pelanggan.isSelected;
  }

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

  @override
  void onClose() {
    super.onClose();
    savePelangganToPrefs();
  }
}
