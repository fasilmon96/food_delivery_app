 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/core/constant/image_constant.dart';
import 'package:my_project/core/constant/meadiaquery_value.dart';
import 'package:my_project/core/constant/text_constant.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/features/wallet/controller/wallet_controller.dart';
import 'package:my_project/theme/pallete.dart';

import '../../../core/common/validations.dart';

class Wallet extends ConsumerStatefulWidget {
   const Wallet({super.key});

   @override
   ConsumerState<Wallet> createState() => _WalletState();
 }

 class _WalletState extends ConsumerState<Wallet> {
   TextEditingController amountController = TextEditingController();
   final _formKey = GlobalKey<FormState>();
   void updateWallet({required String amount,}){
     ref.read(walletControllerProvider).
     updateWallet(
         amount: amount,
         context: context,
     );
   }
   @override
  void dispose() {
      amountController.dispose();
    super.dispose();
  }
   @override
   Widget build(BuildContext context) {
     final user = ref.watch(userProvider)!;
     return Scaffold(
       body:Container(
         margin: EdgeInsets.only(top: 60),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Material(
               elevation: 2,
               child: Container(
                 padding: EdgeInsets.only(bottom: 10),
                 child: Center(
                     child: Text("Wallet",
                       style:GoogleStyle.headlineTextFieldStyle(),
                     )),
               ),
             ),
             SizedBox(height: 30,),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
             width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: Pallete.message4,
            ),
               child: Row(
                 children: [
                   Image.asset(
                     ImageConstant.wallet,
                     height: 60,
                     width: 60,
                     fit: BoxFit.cover,
                   ),
                   SizedBox(width: 40,),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Your Wallet",style: GoogleStyle.lightTextFieldStyle(),),
                       SizedBox(height: 5,),
                       Text("₹${user.wallet}",style: GoogleStyle.boldTextFieldStyle(),)
                     ],
                   )
                 ],
               ),
             ),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.only(left: 20),
               child: Text("Add Money",style: GoogleStyle.semiBoldTextFieldStyle(),),
             ),
             SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children:List.generate(ImageConstant.priceWidget.length, (index) {
                  final price = ImageConstant.priceWidget[index].toString();
                 return GestureDetector(
                     onTap: () {
                       updateWallet(
                           amount:price,
                       );
                     },
                   child: Container(
                       padding: EdgeInsets.all(5),
                       decoration: BoxDecoration(
                         color: Pallete.message5,
                         borderRadius: BorderRadius.circular(5),
                       ),
                       child: Text("₹$price",style: GoogleStyle.semiBoldTextFieldStyle(),)),
                 );
               },),
             ),
             SizedBox(height: 40,),
             GestureDetector(
               onTap: () {
                 showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                         content: SingleChildScrollView(
                           child: Container(
                             margin: EdgeInsets.symmetric(vertical: 10),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                     GestureDetector(
                                         onTap: () {
                                           Navigator.pop(context);
                                         },
                                         child: Icon(Icons.cancel)),
                                     SizedBox(width: 60,),
                                     Center(
                                       child: Text("Add Money",style: TextStyle(
                                           color: Colors.green,
                                           fontWeight: FontWeight.bold
                                       ),),
                                     )
                                   ],
                                 ),
                                 SizedBox(height: 20,),
                                 Text("Amount"),
                                 SizedBox(height: 20,),
                                 Form(
                                   key:_formKey,
                                   child: Container(
                                       padding: EdgeInsets.symmetric(horizontal: 10),
                                       decoration: BoxDecoration(
                                           border: Border.all(
                                             color: Colors.black38,),
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child:
                                       TextFormField(
                                         controller:amountController,
                                         keyboardType: TextInputType.number,
                                         validator: (value) {
                                           return Validation.numberValidation(value!);
                                         },
                                         autovalidateMode: AutovalidateMode.onUserInteraction,
                                         decoration:InputDecoration(
                                             border: InputBorder.none,
                                             hintText: "Enter Amount",
                                             hintStyle: TextStyle(
                                                 color: Pallete.message6
                                             ),
                                         ),
                                       )
                                   ),
                                 ),
                                 SizedBox(height:30,),
                                 GestureDetector(
                                   onTap:  () {
                                    if(_formKey.currentState!.validate()){
                                      Navigator.pop(context);
                                      updateWallet(amount: amountController.text);
                                      amountController.clear();
                                    }
                                   },
                                   child: Center(
                                     child: Container(
                                       alignment: Alignment.center,
                                       width: 80,
                                       padding: EdgeInsets.symmetric(vertical: 10),
                                       decoration: BoxDecoration(
                                         color: Pallete.message6,
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       child: Text("Pay",style: TextStyle(
                                           color: Pallete.whiteColor
                                       ),),
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           ),
                         )
                     );
                   },
                 );
                 },
               child: Container(
                 margin: EdgeInsets.symmetric(horizontal:20),
                 padding: EdgeInsets.symmetric(vertical: 12),
                 width: SizeConfig.screenWidth,
                 decoration: BoxDecoration(
                   color: Pallete.message6,
                   borderRadius: BorderRadius.circular(12)
                 ),
                 child: Center(
                   child: Text("Add Money",style:GoogleFonts.poppins(
                     fontSize: 18,
                     color: Pallete.whiteColor,
                     fontWeight: FontWeight.bold
                   ) ,),
                 ),
               ),
             )
           ],
         ),
       ) ,
     );
   }
 }
