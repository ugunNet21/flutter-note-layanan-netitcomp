// model/pelanggan_model.dart
class Pelanggan {
  int idPelanggan;
  String namaPelanggan;
  String alamat;
  String nomorTelepon;
  String email;
  bool isSelected;

  Pelanggan({
    required this.idPelanggan,
    required this.namaPelanggan,
    required this.alamat,
    required this.nomorTelepon,
    required this.email,
    this.isSelected = false,
  });
  // Metode untuk mengonversi objek Pelanggan menjadi Map
  Map<String, dynamic> toJson() {
    return {
      'idPelanggan': idPelanggan,
      'namaPelanggan': namaPelanggan,
      'alamat': alamat,
      'nomorTelepon': nomorTelepon,
      'email': email,
    };
  }

  // Metode untuk membuat objek Pelanggan dari Map
  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      idPelanggan: json['idPelanggan'],
      namaPelanggan: json['namaPelanggan'],
      alamat: json['alamat'],
      nomorTelepon: json['nomorTelepon'],
      email: json['email'],
       isSelected: false,
    );
  }
}

// model/laptop_model.dart
class Laptop {
  int idLaptop;
  String kodeSerialNumber;
  String merek;
  String tipe;
  String jenisKerusakan;

  Laptop({
    required this.idLaptop,
    required this.kodeSerialNumber,
    required this.merek,
    required this.tipe,
    required this.jenisKerusakan,
  });
}

// model/teknisi_model.dart
class Teknisi {
  int idTeknisi;
  String namaTeknisi;
  String alamat;
  String nomorTelepon;
  String keterampilan;

  Teknisi({
    required this.idTeknisi,
    required this.namaTeknisi,
    required this.alamat,
    required this.nomorTelepon,
    required this.keterampilan,
  });
}

// model/proses_perbaikan_model.dart
class ProsesPerbaikan {
  int idProsesPerbaikan;
  int idInvoice;
  int idLaptop;
  String jenisKerusakan;
  String komponenYangDiganti;
  DateTime waktuPerbaikan;

  ProsesPerbaikan({
    required this.idProsesPerbaikan,
    required this.idInvoice,
    required this.idLaptop,
    required this.jenisKerusakan,
    required this.komponenYangDiganti,
    required this.waktuPerbaikan,
  });
}

// model/invoice_model.dart
class Invoice {
  int idInvoice;
  String kodeInvoice;
  DateTime tanggalInvoice;
  String namaPelanggan;
  int biayaService;
  String jenisService;
  int biayaSparepart;
  String jenisSparepart;
  int biayaExpedisi;
  String namaTeknisi;
  int modalService;
  int modalSparepart;
  int labaRugi;
  String garansi;
  String pembayaran;

  Invoice({
    required this.idInvoice,
    required this.kodeInvoice,
    required this.tanggalInvoice,
    required this.namaPelanggan,
    required this.biayaService,
    required this.jenisService,
    required this.biayaSparepart,
    required this.jenisSparepart,
    required this.biayaExpedisi,
    required this.namaTeknisi,
    required this.modalService,
    required this.modalSparepart,
    required this.labaRugi,
    required this.garansi,
    required this.pembayaran,
  });
}
