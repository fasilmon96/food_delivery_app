import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/providers/firebase_providers.dart';
import 'package:my_project/model/product_model.dart';

final homeRepositoryProvider = Provider(
  (ref) => HomeRepository(firestore: ref.watch(firestoreProvider)),
);

class HomeRepository {
  final FirebaseFirestore _firestore;
  HomeRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  Stream<List<ProductModel>> foodItems(String name) {
    return _firestore
        .collection(name)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => ProductModel.fromJson(e.data())).toList(),
        );
  }
}
