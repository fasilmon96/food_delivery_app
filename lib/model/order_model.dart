class OrderModel {
  final String orderId;
  final String name;
  final String email;
  final String total;
  final String image;
  final String status;
  final String paymentMethod;
  final DateTime date;
  final List<dynamic> item; // Usually List<Map<String, dynamic>>

  OrderModel({
    required this.orderId,
    required this.name,
    required this.email,
    required this.total,
    required this.image,
    required this.status,
    required this.paymentMethod,
    required this.date,
    required this.item,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json["orderId"],
    name: json["name"],
    email: json["email"],
    total: json["total"],
    image: json["image"],
    status: json["status"],
    paymentMethod: json["paymentMethod"],
    date:  json["date"].toDate(),
    item: json["item"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "name": name,
    "email": email,
    "total": total,
    "image": image,
    "status": status,
    "paymentMethod": paymentMethod,
    "date": date,
    "item": item,
  };

  OrderModel copyWith({
    String? orderId,
    String? name,
    String? email,
    String? total,
    String? image,
    String? status,
    String? paymentMethod,
    DateTime? date,
    List? item,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      name: name ?? this.name,
      email: email ?? this.email,
      total: total ?? this.total,
      image: image ?? this.image,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      date: date ?? this.date,
      item: item ?? this.item,
    );
  }
}
