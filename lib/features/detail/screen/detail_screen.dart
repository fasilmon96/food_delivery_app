import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/core/constant/text_constant.dart';
import 'package:my_project/core/providers/utils.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/features/bottomnavigation/screen/bottomnavigation_screen.dart';
import 'package:my_project/features/cart/controller/cart_controller.dart';
import 'package:my_project/features/home/screen/home_screen.dart';
import 'package:my_project/model/cart_model.dart';
import 'package:my_project/model/product_model.dart';
import 'package:uuid/uuid.dart';
import '../../../core/providers/widgets.dart';
import '../../../theme/pallete.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final ProductModel productModel;
  const DetailScreen({super.key, required this.productModel});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  void addCount() {
    ref.read(countingNumber.notifier).state++;
  }

  void subtractCount() {
    if (ref.read(countingNumber.notifier).state > 1) {
      ref.read(countingNumber.notifier).state--;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(countingNumber.notifier).state = 1;
    }); // itu namukk detail open akumbool refresh ayi kittan;

    super.initState();
  }
  void addCart(int quantity, int total,) {
    final user = ref.watch(userProvider)!;
    CartModel cartModel = CartModel(
      cartId: widget.productModel.id,
      productId: widget.productModel.id,
      name: widget.productModel.name,
      quantity: quantity.toString(),
      total: total.toString(),
      image: widget.productModel.image,
    );
    ref.read(cartControllerProvider).addCart(user.id, cartModel,context);
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(countingNumber);
    final price = int.parse(widget.productModel.price);
    final total = count * price;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Pallete.blackColor,
              ),
            ),
            Image.network(
              widget.productModel.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productModel.name,
                      style: GoogleStyle.boldTextFieldStyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    subtractCount();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Pallete.blackColor,
                    ),
                    child: Icon(Icons.remove, color: Pallete.whiteColor),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  count.toString(),
                  style: GoogleStyle.semiBoldTextFieldStyle(),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    addCount();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Pallete.blackColor,
                    ),
                    child: Icon(Icons.add, color: Pallete.whiteColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              widget.productModel.details,
              maxLines: 4,
              style: GoogleStyle.lightTextFieldStyle(),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "Delivery Time",
                  style: GoogleStyle.semiBoldTextFieldStyle(),
                ),
                SizedBox(width: 25),
                Icon(Icons.alarm, color: Colors.black54),
                SizedBox(width: 5),
                Text("30 min", style: GoogleStyle.semiBoldTextFieldStyle()),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: GoogleStyle.semiBoldTextFieldStyle(),
                    ),
                    Text("₹$total", style: GoogleStyle.boldTextFieldStyle()),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        addCart(count, total);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Pallete.blackColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Add to Cart",
                              style: GoogleFonts.poppins(
                                color: Pallete.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Pallete.messageColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: Pallete.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
