import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_01/models/products.dart';

class ProductsProvider extends ChangeNotifier {
  static const apiEndpoint = "http://143.198.61.94/api/products/";

  bool isLoading = true;
  String error = "";
  Products products = Products(data: []);

  // get
  getProductFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        products = productsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
