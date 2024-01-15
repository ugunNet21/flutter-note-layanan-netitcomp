// import 'package:flutter/material.dart';
// import 'package:flutter_layanan_netitcomp/models/data_model.dart';
// import 'package:flutter_layanan_netitcomp/pages/pelanggan/pelanggan_controller.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class PelangganPage extends StatelessWidget {
//   final PelangganController pelangganController = Get.put(PelangganController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pelanggan Page'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Pelanggan newPelanggan = Pelanggan(
//                 idPelanggan: DateTime.now().millisecondsSinceEpoch,
//                 namaPelanggan: 'John Doe',
//                 alamat: '123 Main Street',
//                 nomorTelepon: '123-456-7890',
//                 email: 'john.doe@example.com',
//               );
//               pelangganController.tambahPelanggan(newPelanggan);
//             },
//             child: Text('Tambah Pelanggan'),
//           ),
//           Obx(
//             () => Expanded(
//               child: ListView.builder(
//                 itemCount: pelangganController.pelangganList.length,
//                 itemBuilder: (context, index) {
//                   Pelanggan pelanggan = pelangganController.pelangganList[index];
//                   return ListTile(
//                     title: Text(pelanggan.namaPelanggan),
//                     subtitle: Text(pelanggan.email),
//                     onTap: () {
//                       // Navigasi ke halaman detail pelanggan
//                       Get.to(() => DetailPelangganPage(index: index));
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DetailPelangganPage extends StatelessWidget {
//   final int index;

//   const DetailPelangganPage({Key? key, required this.index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final PelangganController pelangganController = Get.find();
//     Pelanggan pelanggan = pelangganController.getDetailPelanggan(index);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Pelanggan'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Nama Pelanggan: ${pelanggan.namaPelanggan}'),
//           Text('Alamat: ${pelanggan.alamat}'),
//           Text('Nomor Telepon: ${pelanggan.nomorTelepon}'),
//           Text('Email: ${pelanggan.email}'),
//           ElevatedButton(
//             onPressed: () {
//               // Navigasi ke halaman edit pelanggan
//               Get.to(() => EditPelangganPage(index: index));
//             },
//             child: Text('Edit Pelanggan'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Menghapus pelanggan
//               pelangganController.hapusPelanggan(index);
//               // Kembali ke halaman sebelumnya
//               Get.back();
//             },
//             child: Text('Hapus Pelanggan'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EditPelangganPage extends StatelessWidget {
//   final int index;

//   const EditPelangganPage({Key? key, required this.index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final PelangganController pelangganController = Get.find();
//     Pelanggan pelanggan = pelangganController.getDetailPelanggan(index);

//     // Implementasi form editing pelanggan
//     // ...

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Pelanggan'),
//       ),
      
//     );
//   }
// }