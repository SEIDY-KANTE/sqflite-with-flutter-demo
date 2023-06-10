class Product{
 late int id;
  String name;
  String description;
  double unitPrice;

  Product.withID(this.id, this.name,this.description,this.unitPrice);
  Product(this.name,this.description,this.unitPrice);

}