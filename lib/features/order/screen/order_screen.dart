import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/common/error_text.dart';
import 'package:my_project/core/common/loader.dart';
import 'package:my_project/core/constant/meadiaquery_value.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/features/cart/controller/cart_controller.dart';
import 'package:my_project/features/order/controller/order_controller.dart';
import 'package:my_project/theme/pallete.dart';
import '../../../core/constant/text_constant.dart';
import '../widget/order_widget.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  void updateWallet({required String amount}) {
    ref.read(cartControllerProvider).updateWallet(amount, context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(child: Text(
              "Food Order",style: GoogleStyle.headlineTextFieldStyle(),)),
           SizedBox(height: 30,),
           ref.watch(streamOrderProvider(user.id)).when(
               data: (data) =>
                  data.isEmpty?
                      SizedBox(
                        height: SizeConfig.screenHeight*2.5,
                        child: Center(
                          child: Text("No order"),
                        ),
                      ):
                   ListView.separated(
                 physics: BouncingScrollPhysics(),
                 itemCount: data.length,
                 shrinkWrap: true,
                 scrollDirection: Axis.vertical,
                 itemBuilder: (context, index) {
                   final order = data[index];
                   return OrderWidget(orderModel: order,);
                 },
                 separatorBuilder: (context, index) {
                   return SizedBox(height: 15);
                 },
               ),
               error: (error, stackTrace) => ErrorText(error: error.toString()),
               loading: () => Loader(),
           )
          ],
        ),
      ),
    );
  }
}
