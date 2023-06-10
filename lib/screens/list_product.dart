import 'package:flutter/material.dart';
import 'package:flutter_with_sqflite_demo/data/db_helper.dart';
import 'package:flutter_with_sqflite_demo/screens/add_prodcut.dart';

import '../models/product.dart';

class ListProduct extends StatefulWidget{
  const ListProduct({super.key});

  @override
  State<StatefulWidget> createState()=>_ListProduct();
}

class _ListProduct extends State<ListProduct>{
  var dbHelper= DbHelper();
  late List<Product> products;
  int productCount=0;

  @override
  void initState()  {
    var productResult= dbHelper.getProducts();
    productResult.then((data) => products=data);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Of Products"),
      ),
      body:ListView.builder(itemCount:productCount ,itemBuilder: (BuildContext context, int index){
        return Card(
          color: Colors.cyan,
          elevation: 2,
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.black12, child: Text("P"),),
            title: Text("${products[index].name}"),
            subtitle: Text("${products[index].description}"),
          ),
      );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: "Add a new product",
        onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddProduct()));
        },
    ),
    );
  }
}