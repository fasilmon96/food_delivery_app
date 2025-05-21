import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/features/bottomnavigation/screen/bottomnavigation_screen.dart';
import 'core/common/error_text.dart';
import 'core/common/loader.dart';
import 'core/constant/meadiaquery_value.dart';
import 'core/constant/service.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/onboard/screen/onboard.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'model/user_model.dart';


 void main()async{
   WidgetsBinding widgetsBinding =WidgetsFlutterBinding.ensureInitialized();
   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
   Stripe.publishableKey = publishableKey;
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,);
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
     statusBarColor: Colors.transparent, // make it blend with the top container
     statusBarIconBrightness: Brightness.dark, // icon
     ));
     runApp(
          ProviderScope(
              child: MyApp())
        );

   }
   class MyApp extends ConsumerStatefulWidget {
     const MyApp({super.key});

     @override
     ConsumerState<MyApp> createState() => _MyAppState();
   }

   class _MyAppState extends ConsumerState<MyApp> {
     UserModel? userModel;
     void getData(WidgetRef ref , User data) async{
       userModel = await ref.watch(authControllerProvider).getUserData(data.uid).first;
       ref.read(userProvider.notifier).update((state)=>userModel);
       setState(() {

       });

     }
     @override
     void initState() {
       super.initState();
       WidgetsBinding.instance.addPostFrameCallback((_) {
         Future.delayed(const Duration(seconds: 1), () {
           FlutterNativeSplash.remove();
         });
       });
     }

  @override
    Widget build(BuildContext context) {
       SizeConfig.init(context);
       return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
            },
         child: MaterialApp(
           title: "Food_App_Tutorial",
           debugShowCheckedModeBanner: false,
           home: Scaffold(
             body: ref.watch(authStateChangeProvider).when(
               data: (data) {
                 if(data!=null){
                   getData(ref, data);
                   if(userModel!=null){
                     return BottomNavigationScreen();
                   }
                 }
                 return Onboard();
               },
               error: (error, stackTrace) => ErrorText(error: error.toString()),
               loading: () => Loader(),
             ),
           ),
         ),
       );
     }
   }
