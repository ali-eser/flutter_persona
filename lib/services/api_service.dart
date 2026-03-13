import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_persona/model/product.dart';

class ApiService {
  Future<List<Product>> fetch () async {
    final res = await http.get(
      Uri.parse("https://fakestoreapi.com/products")
    );
    if (res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);

      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Something gone wrong.");
    }
  }
}