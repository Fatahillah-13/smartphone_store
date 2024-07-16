// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'api_service.dart';
import 'smartphone.dart';

class DetailPage extends StatefulWidget {
  final Smartphone smartphone;

  DetailPage({required this.smartphone});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ApiService _apiService = ApiService();
  int _quantity = 1;

  void _addOrder(BuildContext context) async {
    if (_quantity <= 0 || _quantity > widget.smartphone.jumlah) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jumlah tidak valid')),
      );
      return;
    }

    try {
      await _apiService.addOrder(
          widget.smartphone.id, widget.smartphone.nama, _quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pesanan berhasil ditambahkan')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan pesanan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.smartphone.nama),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.smartphone.gambar,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.smartphone.nama,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Stok: ${widget.smartphone.jumlah}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Harga: Rp${widget.smartphone.harga.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) {
                        _quantity--;
                      }
                    });
                  },
                ),
                Text(
                  _quantity.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (_quantity < widget.smartphone.jumlah) {
                        _quantity++;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              widget.smartphone.deskripsi,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addOrder(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text('Beli Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
