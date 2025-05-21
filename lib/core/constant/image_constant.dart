import 'package:flutter/cupertino.dart';
import 'package:my_project/features/cart/screen/cart_screen.dart';
import 'package:my_project/features/home/screen/home_screen.dart';
import 'package:my_project/features/order/screen/order_screen.dart';
import 'package:my_project/features/profile/screen/profile_screen.dart';
import 'package:my_project/features/wallet/screen/wallet.dart';

class ImageConstant{
     static const boy = "assets/images/boy.jpg";
     static const burger = "assets/images/burger.png";
     static const food = "assets/images/food.jpg";
     static const iceCream = "assets/images/ice-cream.png";
     static const logo = "assets/images/logo.png";
     static const pizza = "assets/images/pizza.png";
     static const salad = "assets/images/salad.png";
     static const salad2 = "assets/images/salad2.png";
     static const salad3 = "assets/images/salad3.png";
     static const salad4 = "assets/images/salad4.png";
     static const screen1 = "assets/images/screen1.png";
     static const screen2 = "assets/images/screen2.png";
     static const screen3 = "assets/images/screen3.png";
     static const wallet = "assets/images/wallet.png";
     static const img1   = "assets/images/cu1.jpg";
     static const img2   = "assets/images/cu2.png";
     static const img3  = "assets/images/cur3.jpg";
     static const img4   = "assets/images/cur4.jpg";
     static const img5   = "assets/images/cur5.jpg";
     static const img6   = "assets/images/cur6.jpg";
     static const img7   = "assets/images/cur7.jpg";
     static const avatarDefault = 'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';
     static const category = [
      ImageConstant.iceCream,
      ImageConstant.burger,
      ImageConstant.salad,
      ImageConstant.pizza,
     ];
     static const List<String> categoryItem=["Ice-cream"  ,"Burger" , "Salad","Pizza"];
     static List tabWidget =  [
       HomeScreen(),
       OrderScreen(),
       Wallet(),
       ProfileScreen(),
     ];
     static  List<int> priceWidget = [
         int.parse("2000"),
         int.parse("5000",),
         int.parse( "10000"),
         int.parse("20000"),
     ];
     static const images = [
        ImageConstant.img1,
        ImageConstant.img2,
        ImageConstant.img3,
        ImageConstant.img4,
        ImageConstant.img5,
        ImageConstant.img6,
        ImageConstant.img7,
     ];

    }