import 'package:flutter/material.dart';
import 'package:my_project/model/product_model.dart';
import '../../../core/constant/text_constant.dart';
import '../../../theme/pallete.dart';
import '../../detail/screen/detail_screen.dart';

class ProductTile extends StatefulWidget {
    final ProductModel productModel;
  const ProductTile({super.key,
    required this.productModel
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productModel: widget.productModel,),));
       },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:Pallete.message3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(widget.productModel.image,height: 120,width: 120,fit: BoxFit.contain,),
            SizedBox(height: 5,),
            Text(widget.productModel.name,style:GoogleStyle.boldTextFieldStyle(),),
            SizedBox(height: 5,),
            Text("Fresh and Healthy",style:GoogleStyle.lightTextFieldStyle(),),
            SizedBox(height: 5,),
            Text("₹${widget.productModel.price}",style:GoogleStyle.boldTextFieldStyle(),),
          ],
        ),
      ),
    );
  }
}
