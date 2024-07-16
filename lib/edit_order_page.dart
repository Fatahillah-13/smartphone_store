// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'api_service.dart';
import 'order.dart';

class EditOrderPage extends StatefulWidget {
  final Order order;

  EditOrderPage({required this.order});

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.order.jumlah_pembelian;
  }

  void _updateOrder() async {
    await ApiService().updateOrder(widget.order.id_pembelian, _quantity);
    Navigator.pop(context, true); // Mengembalikan nilai true jika berhasil
  }

  void _deleteOrder() async {
    await ApiService().deleteOrder(widget.order.id_pembelian);
    Navigator.pop(context, true); // Mengembalikan nilai true jika berhasil
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.order.nama_barang,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                ),
                Text(_quantity.toString(), style: TextStyle(fontSize: 20)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _updateOrder,
                  child: Text('Update'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _deleteOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Hapus'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
