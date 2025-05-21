import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/features/order/repository/order_repsository.dart';
import 'package:my_project/model/order_model.dart';

final orderControllerProvider = Provider(
  (ref) => OrderController(orderRepository: ref.watch(orderRepositoryProvider)),
);
final streamOrderProvider = StreamProvider.autoDispose.family(
  (ref, String userId) =>
      ref.watch(orderControllerProvider).streamOrder(userId),
);

class OrderController {
  final OrderRepository _orderRepository;
  OrderController({required OrderRepository orderRepository})
    : _orderRepository = orderRepository;

  Future<void> addOrder(OrderModel orderModel) async {
    await _orderRepository.addOrder(orderModel);
  }

  Stream<List<OrderModel>> streamOrder(String userId) {
    return _orderRepository.streamOrder(userId);
  }
}
