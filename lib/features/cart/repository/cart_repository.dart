
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_project/core/constant/firebase_constant.dart';
import 'package:my_project/core/providers/firebase_providers.dart';
import 'package:my_project/core/providers/utils.dart';
import 'package:my_project/model/cart_model.dart';
import '../../auth/controller/auth_controller.dart';

final cartRepositoryProvider = Provider(
  (ref) => CartRepository(firestore: ref.watch(firestoreProvider), ref: ref),
);

class CartRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;
  CartRepository({required FirebaseFirestore firestore,required Ref ref})
    : _firestore = firestore,
    _ref = ref;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Future<void> addCart(String userId, CartModel cartModel) async {
    final cartRef = _users
        .doc(userId)
        .collection(FirebaseConstants.cartCollection)
        .doc(cartModel.cartId); // cartId should be productModel.id

    final cartDoc = await cartRef.get();

    if (!cartDoc.exists) {
      await cartRef.set(cartModel.toJson());
    } else {
      final existingData = cartDoc.data() as Map<String, dynamic>;
      final currentQuantity = int.tryParse(existingData['quantity'].toString()) ?? 0;
      final currentTotal = int.tryParse(existingData['total'].toString()) ?? 0;
      final newQuantity = currentQuantity + int.parse(cartModel.quantity);
      final newTotal = currentTotal + int.parse(cartModel.total);

      await cartRef.update({
        'quantity': newQuantity.toString(),
        'total': newTotal.toString(),
      });
    }
  }

  Stream<List<CartModel>>streamCart(String id){
     return _users.doc(id).collection(FirebaseConstants.cartCollection)
         .snapshots().map((event) => event.docs.map((e) =>CartModel.fromJson(e.data()),).toList(),);
  }

  Future<void> updateWallet(String amount,context,) async {
    try {
      final user =_ref.watch(userProvider)!;
      final updateAmount = user.wallet - int.parse(amount);
      await _users.doc(user.id).update({"wallet" :updateAmount});
      // 4. Success Dialog
    } on StripeException catch (e) {
     showSnackBar(text: e.toString(), context: context);
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(content: Text("Payment Cancelled")),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);  // Close the dialog after delay
      });
    } catch (e) {
      showSnackBar(text: e.toString(), context: context);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCartOnce(String userId) {
    return _users
        .doc(userId)
        .collection(FirebaseConstants.cartCollection)
        .get();
  }

  Future<void> clearCart(String userId) async {
    final cartItems = await _users
        .doc(userId)
        .collection(FirebaseConstants.cartCollection)
        .get();

    for (final doc in cartItems.docs) {
      await doc.reference.delete();
    }
  }

}
