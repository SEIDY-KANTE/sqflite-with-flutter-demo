class Product {
   int? id;
   String? name;
   String? description;
   double? unitPrice;

  Product.withID(this.id, this.name, this.description, this.unitPrice);
  Product(this.name, this.description, this.unitPrice);

  Product.fromObj(dynamic obj) {
    this.id = int.parse(obj["id"].toString());
    this.name = obj["name"];
    this.description = obj["description"];
    this.unitPrice = double.parse(obj["unitPrice"].toString());
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = this.name;
    map["description"] = this.description;
    map["unitPrice"] = this.unitPrice;
    if (id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}
