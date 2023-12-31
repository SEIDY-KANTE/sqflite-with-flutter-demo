import 'package:flutter/material.dart';
import 'package:flutter_with_sqflite_demo/data/db_helper.dart';
import 'package:flutter_with_sqflite_demo/screens/add_product.dart';
import 'package:flutter_with_sqflite_demo/screens/details_product.dart';

import '../models/product.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<StatefulWidget> createState() => _ListProduct();
}

class _ListProduct extends State<ListProduct> {
  var dbHelper = DbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  void initState() {
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Of Products"),
      ),
      body: ListView.builder(
          itemCount: productCount,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.cyan,
              elevation: 2,
              child: buildProduct(index),
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new product",
        child: const Icon(Icons.add),
        onPressed: () {
          gotoAddProduct();
        },
      ),
    );
  }

  buildProduct(int index) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Text("P"),
      ),
      title: Text("${products?[index].name}"),
      subtitle: Text("${products?[index].description}"),
      onTap: () {
        gotoDetails(products![index]);
      },
    );
  }

  gotoAddProduct() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (builder) => const AddProduct()));
    if (result != null) {
      if (result) {
        getProduct();
      }
    }
  }

  void getProduct() {
    var productResult = dbHelper.getProducts();
    productResult.then((data) => {
          setState(() {
            products = data;
            productCount = data.length;
          })
        });
  }

  void gotoDetails(Product product) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (builder) => DetailsProduct(product)));
    if (result != null) {
      if (result) {
        getProduct();
      }
    }
  }
}
