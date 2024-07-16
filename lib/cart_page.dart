// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'api_service.dart';
import 'order.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Order>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = ApiService().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Keranjang belanja masih kosong.'));
          } else {
            List<Order> orders = snapshot.data!;
            double totalPrice = orders.fold(0,
                (sum, order) => sum + (order.harga * order.jumlah_pembelian));

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return ListTile(
                        leading: Image.network(order.gambar,
                            height: 50, width: 50, fit: BoxFit.cover),
                        title: Text(order.nama_barang),
                        subtitle: Text('Jumlah: ${order.jumlah_pembelian}'),
                        trailing:
                            Text('Rp. ${order.harga * order.jumlah_pembelian}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Harga: Rp${totalPrice.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
