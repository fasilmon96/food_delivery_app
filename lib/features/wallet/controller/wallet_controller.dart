import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/features/wallet/repository/wallet_repository.dart';
 final walletControllerProvider = Provider((ref) => WalletController(
     walletRepository: ref.watch(
         walletRepositoryProvider)),);
class WalletController{
   final WalletRepository _walletRepository;
   WalletController({required WalletRepository walletRepository}):_walletRepository=walletRepository;

     void updateWallet({required String amount ,required BuildContext context}) {
        _walletRepository.updateWallet(amount, context,);
    }
  }