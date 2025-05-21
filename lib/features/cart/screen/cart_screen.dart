import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/core/common/error_text.dart';
import 'package:my_project/core/common/loader.dart';
import 'package:my_project/core/constant/meadiaquery_value.dart';
import 'package:my_project/core/providers/utils.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/features/cart/controller/cart_controller.dart';
import 'package:my_project/features/cart/widget/cart_widget.dart';
import 'package:my_project/features/order/controller/order_controller.dart';
import 'package:my_project/model/order_model.dart';
import 'package:my_project/theme/pallete.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constant/text_constant.dart';
import '../../../core/providers/widgets.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  Future<void> updateWallet({required String amount,})async{
   await ref.read(cartControllerProvider).updateWallet(amount, context);
  }
  Future<void>clearCart()async{
    final user = ref.read(userProvider)!;
  await ref.read(cartControllerProvider).clearCart(user.id);
  }
  Future<void> addOrder(int totalPrice)async {
    final orderId = const Uuid().v1();
    final user = ref.read(userProvider)!;
    final cartList = await ref
        .read(cartControllerProvider)
        .getCartListOnce(user.id);// List<CartModel>
    final itemsForOrder = cartList.map((e) => e.toJson()).toList();
    OrderModel orderModel = OrderModel(
        orderId: orderId,
        name: user.name,
        email: user.email,
        total: totalPrice.toString(),
        image: user.profilePic,
        status: "Pending",
        paymentMethod: "Wallet",
        date: DateTime.now(),
        item:itemsForOrder
    );
   await ref.read(orderControllerProvider).addOrder(orderModel);
  }
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final totalPrice = ref.watch(totalPriceProvider(user.id));
    final cartAsync = ref.watch(cartStreamProvider(user.id));
    final amount = totalPrice.toString();
    return Scaffold(
       backgroundColor: Pallete.whiteColor,
      appBar: AppBar(
        backgroundColor: Pallete.whiteColor,
        surfaceTintColor:Pallete.whiteColor,
        leading: GestureDetector(
             onTap: () {
               Navigator.pop(context);
             },
            child: Icon(Icons.arrow_back_ios_outlined)),
        title: Text("Food Cart",style: GoogleStyle.headlineTextFieldStyle(),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
              Expanded(
                child: cartAsync.when(
                   data: (data) {
                     return  data.isEmpty?
                     SizedBox(
                       height: SizeConfig.screenHeight / 2,
                       child: Center(
                         child: Text(
                           "No Cart",
                           style: GoogleStyle.boldTextFieldStyle(),
                         ),
                       ),
                     ):
                         ListView.separated(
                           physics: BouncingScrollPhysics(),
                           itemCount: data.length,
                           shrinkWrap: true,
                           scrollDirection: Axis.vertical,
                           itemBuilder: (context, index) {
                             final cart = data[index];
                             return CartWidget(cartModel: cart,);
                           },
                           separatorBuilder: (context, index) {
                             return SizedBox(height: 15,);
                           },
                         );
                     },
                     error: (error, stackTrace) => ErrorText(error: error.toString()),
                     loading: () => Loader(),
                 ),
              ),
              SizedBox(height: 10,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Price",style: GoogleStyle.boldTextFieldStyle(),),
                        Text("₹$totalPrice",style: GoogleStyle.boldTextFieldStyle(),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: ()async {
                        if(user.wallet<totalPrice){
                          showSnackBar(text: "No enough wallet amount", context: context);
                        }else{
                            await updateWallet(amount: amount);
                            await addOrder(totalPrice) ;
                            await clearCart();
                            showSnackBar(text: "Checkout successful", context: context);
                        }
                        },
                   child: Container(
                     alignment: Alignment.center,
                     width: SizeConfig.screenWidth,
                     padding: EdgeInsets.symmetric(vertical: 10),
                     decoration: BoxDecoration(
                         color: Pallete.blackColor,
                         borderRadius: BorderRadius.circular(10)
                     ),
                     margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                     child: Text("CheckOut",style: GoogleFonts.poppins(
                         fontSize: 20,
                         color: Pallete.whiteColor,
                         fontWeight: FontWeight.bold
                     ),),
                   ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ) ;
  }
}









