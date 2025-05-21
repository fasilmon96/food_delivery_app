import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/cart/controller/cart_controller.dart';
// class DataTypeNotifier extends ChangeNotifier {
//   int index = 0;
//     panelChange(int newIndex){
//     index =newIndex;
//     notifyListeners();
//   }
// }
// final dataTypeNotifierProvider = ChangeNotifierProvider((ref){
//   return DataTypeNotifier();
// },);

final stateSelectIndex = StateProvider<int>((ref) => 0,);
final countingNumber = StateProvider<int>((ref) => 1,);
final currentIndex = StateProvider<int>((ref) => 0,);
final otpVerifiedProvider = StateProvider<bool>((ref) => false,);
final userIdProvider = StateProvider<String?>((ref) => null);
final pageProvider = StateProvider<int>((ref) => 0,);
final totalPriceProvider = Provider.family<int, String>((ref, userId) {
  final cartAsync = ref.watch(cartStreamProvider(userId));
  return cartAsync.maybeWhen(
    data: (carts) {
      return carts.fold<int>(0, (sum, item) => sum + int.parse(item.total));
    },
    orElse: () => 0,
  );
});







