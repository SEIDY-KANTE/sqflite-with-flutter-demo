import 'package:flutter/material.dart';
import 'package:flutter_with_sqflite_demo/data/db_helper.dart';

import '../models/product.dart';

class DetailsProduct extends StatefulWidget{
  Product product;
  DetailsProduct(this.product,{super.key});

  @override
  State<StatefulWidget> createState()=>_DetailsProduct(product);

}
enum Options{
  delete,
  update
}
class _DetailsProduct  extends State<DetailsProduct>{
  var dbHelper=DbHelper();
   Product product;
  _DetailsProduct(this.product);

  var nameTxt = TextEditingController();
  var descriptionTxt = TextEditingController();
  var unitPriceTxt = TextEditingController();

  @override
  void initState() {
    nameTxt.text=product.name!;
    descriptionTxt.text=product.description! ;
    unitPriceTxt.text=product.unitPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details of : ${product.name}"),
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
              itemBuilder: (BuildContext context)=><PopupMenuEntry<Options>>[
                const PopupMenuItem<Options>(
                  value: Options.delete,
                    child: Text("Delete"),
                ),
                const PopupMenuItem<Options>(
                  value: Options.update,
                  child: Text("Update"),
                )
              ]
          )
        ],
      ),
      body: buildProductDetails(),
    );
  }

  buildProductDetails() {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      children: [
        buildNameField(),
        buildDescriptionField(),
        buildUnitPriceField(),
      ],
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
        labelText: "Description of product",
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

  void selectProcess(Options process) async{
    //print(process);
    switch(process){
      case Options.delete:
        await dbHelper.delete(int.parse(product.id.toString()));
        // ignore: use_build_context_synchronously
        Navigator.pop(context,true);
        break;
      case Options.update:
        /*
        print("${product.id}, ${product.name}, ${product.description}, ${product
            .unitPrice}");
        print("After updating");
        print("${product.id}, ${nameTxt.text}, ${descriptionTxt.text}, ${unitPriceTxt.text}");
        */
        await dbHelper.update(Product.withID(product.id, nameTxt.text, descriptionTxt.text, double.parse(unitPriceTxt.text)));
        // ignore: use_build_context_synchronously
        Navigator.pop(context,true);
      default:
        break;

    }
  }
}