import 'package:flutter/cupertino.dart';
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

  }

  void selectProcess(Options process) async{
    print(process);
    switch(process){
      case Options.delete:
        await dbHelper.delete(int.parse(product.id.toString()));
        // ignore: use_build_context_synchronously
        Navigator.pop(context,true);
        break;
      default:
        break;

    }
  }
}