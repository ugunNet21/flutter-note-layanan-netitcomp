import 'package:flutter_layanan_netitcomp/models/data_model.dart';
import 'package:flutter_layanan_netitcomp/pages/pelanggan/pelanggan_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InvoiceController extends GetxController {
  RxList<Invoice> invoiceList = <Invoice>[].obs;
  PelangganController pelangganController = Get.find();

  // Metode untuk mengambil informasi nama pelanggan dari tabel Pelanggan berdasarkan kode invoice
  String getNamaPelanggan(int idPelanggan) {
    Pelanggan? pelanggan = pelangganController.pelangganList.firstWhere(
      (pelanggan) => pelanggan.idPelanggan == idPelanggan,
      orElse: () => Pelanggan(
          idPelanggan: -1,
          namaPelanggan: 'Pelanggan tidak ditemukan',
          alamat: '',
          nomorTelepon: '',
          email: ''), // Default value jika tidak ditemukan
    );
    return pelanggan.namaPelanggan;
  }

  // Implement methods to fetch, add, update, delete invoice
}
