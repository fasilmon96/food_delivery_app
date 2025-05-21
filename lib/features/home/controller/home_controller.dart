import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/features/home/repository/home_repository.dart';
import 'package:my_project/model/product_model.dart';

final homeControllerProvider = Provider(
  (ref) => HomeController(homeRepository: ref.watch(homeRepositoryProvider)),
);
final streamFoodProvider = StreamProvider.family((ref,String name) =>ref.watch(homeControllerProvider).foodItems(name));

class HomeController {
  final HomeRepository _homeRepository;
  HomeController({required HomeRepository homeRepository})
    : _homeRepository = homeRepository;

  Stream<List<ProductModel>> foodItems(String name) {
    return _homeRepository.foodItems(name);
  }
}
