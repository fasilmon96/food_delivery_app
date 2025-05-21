import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import "package:http/http.dart" as http;
import 'package:my_project/core/constant/firebase_constant.dart';
import '../../../core/constant/service.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
final walletRepositoryProvider = Provider((ref) => WalletRepository(firestore: ref.watch(firestoreProvider),
    stripe: ref.watch(stripeProvider),
    ref: ref
),);
class WalletRepository {
  final FirebaseFirestore _firestore;
  final Stripe _stripe;
  final Ref _ref;
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);
  WalletRepository(
      {required FirebaseFirestore firestore, required Stripe stripe,required Ref ref})
      :_firestore=firestore,
        _stripe=stripe,
        _ref =ref;

    void updateWallet(String amount,context,) async {
    try {
      // 1. Create Payment Intent
      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "amount": (int.parse(amount) * 100).toString(),
          "currency": "INR",
          "payment_method_types[]": "card",
        },
      );

      final paymentIntent = jsonDecode(response.body);

      // 2. Init Payment Sheet with Dark Theme

      await _stripe.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent["client_secret"],
          merchantDisplayName: "Fasil",
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.black,
              primary: Pallete.blueColor,
              secondaryText:  Pallete.textColor,
            ),
            shapes: PaymentSheetShape(
              borderRadius: 10,
              borderWidth: 1,
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
            ),
          ),
        ),
      );
      // 3. Present Payment Sheet

      await _stripe.presentPaymentSheet();
      final user =_ref.watch(userProvider)!;
      final updateAmount = user.wallet + int.parse(amount);
      await _users.doc(user.id).update({"wallet" :updateAmount});
       // 4. Success Dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text("Payment Successful"),
            ],
          ),

        ),
     );
      //   Future.delayed( Duration(seconds: 2), () {
      //   Navigator.pop(context);
      // }); // avasyam undel use akam
      // Automatically close the dialog after some delay
    } on StripeException catch (e) {
      print("Stripe Exception: $e");
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(content: Text("Payment Cancelled")),
      );
      // Future.delayed(const Duration(seconds: 2), () {
      // Navigator.pop(context);  // Close the dialog after delay
      // }); // avasyam undangil use akam
    } catch (e) {
      print("General Error: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Error: ${e.toString()}")),
      );
    }
  }

}