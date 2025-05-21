import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/model/order_model.dart';
import 'package:my_project/theme/pallete.dart';
import '../../../core/constant/text_constant.dart';

class OrderWidget extends StatefulWidget {
   final OrderModel orderModel;
  const OrderWidget({super.key,
    required this.orderModel
  });

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Pallete.message3
          ),
          child: Column(
            spacing: 7,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name : ${widget.orderModel.name}",style: GoogleStyle.semiBoldTextFieldStyle(),),
              Text("Email : ${widget.orderModel.email}",style: GoogleStyle.semiTextFieldStyle(),),
              Text("Date : ${DateFormat('dd-MM-yyyy').format(widget.orderModel.date)}",style: GoogleStyle.semiBoldTextFieldStyle(),),
              Text("PaymentMethod : ${widget.orderModel.paymentMethod}",style: GoogleStyle.semiBoldTextFieldStyle(),),
              Text("Status : ${widget.orderModel.status}...",style: GoogleStyle.semiBoldTextFieldStyle(),),
              Text("TotalPrice : ${widget.orderModel.total}",style: GoogleStyle.semiBoldTextFieldStyle(),),
            ],
          ),
        ),
      ),
    );
  }
}
