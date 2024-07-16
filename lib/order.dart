class Order {
  final int id_pembelian;
  final int id_barang;
  final String nama_barang;
  final int jumlah_pembelian;
  final String gambar; // Menambahkan gambar
  final double harga; // Menambahkan harga

  Order({
    required this.id_pembelian,
    required this.id_barang,
    required this.nama_barang,
    required this.jumlah_pembelian,
    required this.gambar, // Inisialisasi gambar
    required this.harga, // Inisialisasi harga
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id_pembelian: json['id_pembelian'] is int
          ? json['id_pembelian']
          : int.parse(json['id_pembelian']),
      id_barang: json['id_barang'] is int
          ? json['id_barang']
          : int.parse(json['id_barang']),
      nama_barang: json['nama_barang'],
      jumlah_pembelian: json['jumlah_pembelian'] is int
          ? json['jumlah_pembelian']
          : int.parse(json['jumlah_pembelian']),
      gambar: json['gambar'], // Parsing gambar
      harga: json['harga'] is double
          ? json['harga']
          : double.parse(json['harga']), // Parsing harga
    );
  }
}
