import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/model/order_model.dart';

import '../../../core/constant/firebase_constant.dart';
import '../../../core/providers/firebase_providers.dart';

final orderRepositoryProvider = Provider(
  (ref) => OrderRepository(firestore: ref.watch(firestoreProvider), ref: ref),
);

class OrderRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  OrderRepository({required FirebaseFirestore firestore, required Ref ref})
    : _firestore = firestore,
      _ref = ref;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

 Future<void> addOrder(OrderModel orderModel)async {
    final user = _ref.watch(userProvider)!;
  await  _users
        .doc(user.id)
        .collection(FirebaseConstants.orderCollection)
        .doc(orderModel.orderId)
        .set(orderModel.toJson());
  }

  Stream<List<OrderModel>> streamOrder(String userId){
    return  _users.doc(userId).collection(FirebaseConstants.orderCollection).snapshots().
            map((event) => event.docs.map((e) => OrderModel.fromJson(e.data()),).toList(),);
  }

}
