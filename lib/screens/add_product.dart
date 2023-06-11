import 'package:flutter/material.dart';
import 'package:flutter_with_sqflite_demo/data/db_helper.dart';
import 'package:flutter_with_sqflite_demo/models/product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameTxt = TextEditingController();
  var descriptionTxt = TextEditingController();
  var unitPriceTxt = TextEditingController();
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Name of product",
      ),
      controller: nameTxt,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Description of prodcut",
      ),
      controller: descriptionTxt,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Unit Price",
      ),
      controller: unitPriceTxt,
    );
  }

  buildSaveButton() {
    return TextButton(
        child: const Text("Add"),
        onPressed: () {
          addProduct();
        });
  }

  void addProduct() async {
    var result=await dbHelper.insert(Product(
        nameTxt.text, descriptionTxt.text, double.parse(unitPriceTxt.text)));
     // ignore: use_build_context_synchronously
     Navigator.pop(context, true);
  }
}
