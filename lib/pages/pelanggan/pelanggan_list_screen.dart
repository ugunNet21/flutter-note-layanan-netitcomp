import 'package:flutter/material.dart';
import 'package:flutter_layanan_netitcomp/models/data_model.dart';
import 'package:flutter_layanan_netitcomp/pages/pelanggan/pelanggan_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PelangganListScreen extends StatelessWidget {
  final PelangganController pelangganController = Get.find();
  final TextEditingController editNamaController = TextEditingController();
  final TextEditingController editAlamatController = TextEditingController();
  final TextEditingController editNomorTeleponController =
      TextEditingController();
  final TextEditingController editEmailController = TextEditingController();

  // PelangganListScreen({super.key});
  PelangganListScreen({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pelanggan'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: pelangganController.pelangganList.length,
          itemBuilder: (context, index) {
            final pelanggan = pelangganController.pelangganList[index];
            return Dismissible(
              key: Key(pelanggan.idPelanggan.toString()),
              onDismissed: (direction) {
                // Hapus item ketika digeser
                pelangganController.removePelanggan(pelanggan);
              },
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16.0),
              ),
              child: ListTile(
                title: Text(pelanggan.namaPelanggan),
                subtitle: Text(pelanggan.alamat),
                onTap: () {
                  // Tampilkan detail pelanggan
                  pelangganController.showPelangganDetail(context, pelanggan);
                },
                onLongPress: () {
                  // Tandai item ketika ditekan dan ditahan
                  pelangganController.toggleSelected(pelanggan);
                },
                tileColor: pelangganController.isSelected(pelanggan)
                    ? Colors.blue.withOpacity(0.5)
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  void _showPelangganDetail(BuildContext context, Pelanggan pelanggan) {
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
            _showEditForm(context, pelanggan);
          },
          child: const Text('Edit'),
        ),
        ElevatedButton(
          onPressed: () {
            // Fungsi cetak data pelanggan
            pelangganController.printPelangganData(pelanggan);
          },
          child: const Text('Cetak'),
        ),
        ElevatedButton(
          onPressed: () {
            // Fungsi berbagi data pelanggan
            pelangganController.sharePelangganData(pelanggan);
          },
          child: const Text('Bagikan'),
        ),
      ],
    );
  }

  void _showEditForm(BuildContext context, Pelanggan pelanggan) {
    // Menetapkan nilai awal pada controller yang sesuai
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
              decoration: const InputDecoration(labelText: 'Nama Pelanggan')),
          TextField(
              controller: editAlamatController,
              decoration: const InputDecoration(labelText: 'Alamat')),
          TextField(
              controller: editNomorTeleponController,
              decoration: const InputDecoration(labelText: 'Nomor Telepon')),
          TextField(
              controller: editEmailController,
              decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              pelangganController.editPelanggan(
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
}
