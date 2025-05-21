import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/constant/image_constant.dart';
import 'package:my_project/core/providers/widgets.dart';

import '../../../theme/pallete.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  ConsumerState<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends ConsumerState<BottomNavigationScreen> {
  void changePage(value){
    ref.read(pageProvider.notifier).state=value;
  }
  @override
  Widget build(BuildContext context) {
    int page = ref.watch(pageProvider);
    return  Scaffold(
      body: ImageConstant.tabWidget[page],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Pallete.message6,
        height: 50,
        animationDuration: Duration(milliseconds: 500),
        onTap: (value) {
          changePage(value);
        },
        backgroundColor: Pallete.textColor,
        color: Pallete.blackColor,
        items: [
          Icon(
            Icons.home_outlined,
            color: Pallete.whiteColor,
          ),

          Icon(
            Icons.shopping_bag_outlined,
            color: Pallete.whiteColor,
          ),
          Icon(
            Icons.wallet_outlined,
            color: Pallete.whiteColor,
          ),
          Icon(
            Icons.person_2_outlined,
            color: Pallete.whiteColor,
          ),
        ],
      ),
    );
  }
}
