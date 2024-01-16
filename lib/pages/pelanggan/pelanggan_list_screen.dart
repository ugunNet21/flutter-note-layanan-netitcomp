import 'package:flutter/material.dart';
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
                pelangganController.removePelanggan(pelanggan);
              },
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16.0),
              ),
              child: Card(
                elevation: 4.0, // tinggi bayangan card
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(pelanggan.namaPelanggan),
                  subtitle: Text(pelanggan.alamat),
                  onTap: () {
                    pelangganController.showPelangganDetail(context, pelanggan);
                    // pelangganController.showEditForm(context, pelanggan);
                  },
                  onLongPress: () {
                    pelangganController.toggleSelected(pelanggan);
                  },
                  tileColor: pelangganController.isSelected(pelanggan)
                      ? Colors.blue.withOpacity(0.5)
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

