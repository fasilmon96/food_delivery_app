import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/providers/utils.dart';
import 'package:my_project/features/cart/repository/cart_repository.dart';
import 'package:my_project/model/cart_model.dart';

import '../../bottomnavigation/screen/bottomnavigation_screen.dart';

final cartControllerProvider = Provider(
  (ref) => CartController(cartRepository: ref.watch(cartRepositoryProvider)),
);
final cartStreamProvider = StreamProvider.autoDispose.family(
  (ref, String id) => ref.watch(cartControllerProvider).streamCart(id),
);
final cartLengthProvider = Provider.autoDispose.family<int, String>((ref, userId) {
  final cartItems = ref.watch(cartStreamProvider(userId)).value ??[];
  return cartItems.length;
});


class CartController {
  final CartRepository _cartRepository;
  CartController({required CartRepository cartRepository})
    : _cartRepository = cartRepository;

  Future<void> addCart(String id, CartModel cartModel, context)async {
  await  _cartRepository.addCart(id, cartModel);
    showSnackBar(text: "Cart Successfully", context: context);
    await Future.delayed(Duration(seconds: 2));
    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen(),));

  }

  Stream<List<CartModel>> streamCart(String id) {
    return _cartRepository.streamCart(id);
  }


  Future<List<CartModel>> getCartListOnce(String userId) async {
    final snapshot = await _cartRepository.getCartOnce(userId);
    return snapshot.docs.map((doc) => CartModel.fromJson(doc.data())).toList();
  }

  Future<void> updateWallet(String amount, BuildContext context)async {
   await _cartRepository.updateWallet(amount, context);
  }

  Future<void>clearCart(String userId) async {
    try {
      await _cartRepository.clearCart(userId);
    } catch (e) {
      e.toString();
    }
  }


}
