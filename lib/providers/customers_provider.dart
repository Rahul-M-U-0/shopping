import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_01/models/customers.dart';

class CustomersProvider extends ChangeNotifier {
  static const apiEndpoint = "http://143.198.61.94/api/customers/";

  bool isLoading = true;
  String error = "";
  Customers customers = Customers(data: []);

  // get
  getCustomersFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        customers = customersFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // post
  Future<void> postCustomerToAPI(CustomersElement customer) async {
    try {
      Response response = await http.post(
        Uri.parse(apiEndpoint),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(customer.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        customers.data.add(customer);
        error = "";
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // Update
  Future<void> updateCustomerInAPI(CustomersElement updatedCustomer) async {
    try {
      final response = await http.put(
        Uri.parse("$apiEndpoint/${updatedCustomer.id}"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(updatedCustomer.toJson()),
      );

      if (response.statusCode == 200) {
        final index = customers.data.indexWhere(
          (customer) => customer.id == updatedCustomer.id,
        );
        customers.data[index] = updatedCustomer;
        notifyListeners();
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
  }
}
