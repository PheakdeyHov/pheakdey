import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pheakdey_api/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:pheakdey_api/app_url.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // TextEditingControllers for text fields
  TextEditingController txtProductName = TextEditingController();
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtBarcode = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  TextEditingController txtPriceIn = TextEditingController();
  TextEditingController txtPriceOut = TextEditingController();

  // Form Key
  final _keyForm = GlobalKey<FormState>();

  // Function to add a product
  Future<void> _createProduct({
    required String productName,
    required String categoryID,
    required String barcode,
    required String qty,
    required String unitPriceIn,
    required String unitPriceOut,
  }) async {
    var uri = Uri.parse("${AppUrl.url}insert_product.php");
    EasyLoading.show(status: 'Creating...');
    await Future.delayed(const Duration(seconds: 1));
    final response = await http.post(uri, body: {
      'ProductName': productName,
      'CategoryID': categoryID,
      'Barcode': barcode,
      'Qty': qty,
      'UnitPriceIn': unitPriceIn,
      'UnitPriceOut': unitPriceOut,
    });

    if (!mounted) return;

    EasyLoading.dismiss(); // Ensure dismissal of the loading spinner

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Response data: $data"); // Debug print

      if (data['success'] == 1) {
        EasyLoading.showSuccess("${data['msg_success']}");
        // Clear form fields
        txtProductName.clear();
        txtCategory.clear();
        txtBarcode.clear();
        txtQty.clear();
        txtPriceIn.clear();
        txtPriceOut.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${data['msg_error']}"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to connect to server."),
        ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ProductName is required!';
                    }
                    return null;
                  },
                  controller: txtProductName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category is required!';
                    }
                    return null;
                  },
                  controller: txtCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category ID',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Barcode is required!';
                    }
                    return null;
                  },
                  controller: txtBarcode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Barcode',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Qty is required!';
                    }
                    return null;
                  },
                  controller: txtQty,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Qty',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'UnitPriceIn is required!';
                    }
                    return null;
                  },
                  controller: txtPriceIn,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unit Price In',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'UnitPriceOut is required!';
                    }
                    return null;
                  },
                  controller: txtPriceOut,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unit Price Out',
                  ),
                ),
              ),
              Container(
                height: 56,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _createProduct(
                        productName: txtProductName.text.trim(),
                        categoryID: txtCategory.text.trim(),
                        barcode: txtBarcode.text.trim(),
                        qty: txtQty.text.trim(),
                        unitPriceIn: txtPriceIn.text.trim(),
                        unitPriceOut: txtPriceOut.text.trim(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
