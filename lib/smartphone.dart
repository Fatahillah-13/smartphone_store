class Smartphone {
  final int id;
  final String nama;
  final String deskripsi;
  final int jumlah;
  final String gambar;
  final int harga;

  Smartphone({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.jumlah,
    required this.gambar,
    required this.harga,
  });

  factory Smartphone.fromJson(Map<String, dynamic> json) {
    return Smartphone(
      id: int.parse(json['id_barang']),
      nama: json['nama_barang'],
      deskripsi: json['deskripsi_barang'],
      jumlah: int.parse(json['jumlah']),
      gambar: json['gambar'],
      harga: int.parse(json['harga']),
    );
  }
}
