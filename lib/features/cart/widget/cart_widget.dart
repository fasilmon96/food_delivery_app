import 'package:flutter/material.dart';
import 'package:my_project/model/cart_model.dart';
import 'package:my_project/theme/pallete.dart';
import '../../../core/constant/text_constant.dart';

class CartWidget extends StatefulWidget {
   final CartModel cartModel;
  const CartWidget({super.key,
     required this.cartModel
  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            color: Pallete.message3
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 90,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(widget.cartModel.quantity),
              ),
              SizedBox(width: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  widget.cartModel.image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.cartModel.name,style: GoogleStyle.boldTextFieldStyle(),),
                  Text("₹${widget.cartModel.total}",style: GoogleStyle.boldTextFieldStyle(),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
