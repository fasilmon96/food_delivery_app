class ProductModel{
  final String id;
  final String name;
  final  String image;
  final String price;
  final String details;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.details
  });

  factory ProductModel.fromJson(Map<String,dynamic>json)=>ProductModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    price: json["price"],
    details: json["details"],
  );
  Map<String,dynamic>toJson()=>{
    "id" : id,
    "name" : name,
    "image" : image,
    "price" : price,
    "details" : details,
  };
  ProductModel copyWith({
     String? id,
     String? name,
     String? image,
     String? price,
     String? details
  })
  {
    return ProductModel(
      id: id??this.id,
      name: name??this.name,
      image: image??this.image,
      price: price??this.price,
      details: details??this.details,
    );
  }
}
