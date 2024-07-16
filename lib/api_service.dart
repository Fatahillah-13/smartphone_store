import 'dart:convert';
import 'package:http/http.dart' as http;
import 'order.dart';
import 'smartphone.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.99.141/api_smartphones';

  Future<List<Smartphone>> getSmartphones() async {
    final response = await http.get(Uri.parse('$_baseUrl/get_smartphones.php'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((smartphone) => Smartphone.fromJson(smartphone))
          .toList();
    } else {
      throw Exception('Failed to load smartphones');
    }
  }

  Future<void> addOrder(
      int id_barang, String nama_barang, int jumlah_pembelian) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/add_order.php'),
      body: {
        'id_barang': id_barang.toString(),
        'nama_barang': nama_barang,
        'jumlah_pembelian': jumlah_pembelian.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add order');
    }
  }

  Future<List<Order>> getOrders() async {
    final response = await http.get(Uri.parse('$_baseUrl/get_orders.php'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> updateOrder(int id_pembelian, int jumlah_pembelian) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/update_order.php'),
      body: {
        'id_pembelian': id_pembelian.toString(),
        'jumlah_pembelian': jumlah_pembelian.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order');
    }
  }

  Future<void> deleteOrder(int id_pembelian) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/delete_order.php'),
      body: {
        'id_pembelian': id_pembelian.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}
