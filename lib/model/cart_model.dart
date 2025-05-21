class CartModel {
  final String cartId;
  final String productId;
  final String name;
  final String quantity;
  final String total;
  final String image;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.total,
    required this.image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    cartId: json["cartId"],
    productId: json["productId"],
    name: json["name"],
    quantity: json["quantity"],
    total: json["total"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "cartId": cartId,
    "productId": productId,
    "name": name,
    "quantity": quantity,
    "total": total,
    "image": image,
  };

  CartModel copyWith({
    String? cartId,
    String? productId,
    String? name,
    String? quantity,
    String? total,
    String? image,
  }) {
    return CartModel(
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      image: image ?? this.image,
    );
  }
}
