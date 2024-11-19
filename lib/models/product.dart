import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String model;
  String pk;
  Fields fields;

  Product({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  String name;
  String author;
  String description;
  int stockQuantity;
  int price;

  Fields({
    required this.user,
    required this.name,
    required this.author,
    required this.description,
    required this.stockQuantity,
    required this.price,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    author: json["author"],
    description: json["description"],
    stockQuantity: json["stock_quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "author": author,
    "description": description,
    "stock_quantity": stockQuantity,
    "price": price,
  };
}