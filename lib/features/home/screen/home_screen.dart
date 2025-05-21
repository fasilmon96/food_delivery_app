import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/core/common/error_text.dart';
import 'package:my_project/core/common/loader.dart';
import 'package:my_project/core/constant/image_constant.dart';
import 'package:my_project/core/constant/meadiaquery_value.dart';
import 'package:my_project/core/constant/text_constant.dart';
import 'package:my_project/core/providers/widgets.dart';
import 'package:my_project/features/cart/controller/cart_controller.dart';
import 'package:my_project/features/cart/screen/cart_screen.dart';
import 'package:my_project/features/home/controller/home_controller.dart';
import 'package:my_project/features/home/widget/product_tile.dart';
import 'package:my_project/theme/pallete.dart';

import '../../auth/controller/auth_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
    const HomeScreen({super.key,
    });
  
    @override
    ConsumerState<HomeScreen> createState() => _HomeScreenState();
  }
  
  class _HomeScreenState extends ConsumerState<HomeScreen> {

      void changeSelectIndex(index){
        ref.read(stateSelectIndex.notifier).state=index;
      }
      @override
    Widget build(BuildContext context) {
      final data = ref.watch(userProvider)!;
      final selectIndex = ref.watch(stateSelectIndex);
      final streamFoodAsync = ref.watch(streamFoodProvider(ImageConstant.categoryItem[selectIndex]));
      final cartLength = ref.watch(cartLengthProvider(data.id));
      return Scaffold(
        backgroundColor: Pallete.whiteColor,
        body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20).copyWith(
                    top: 60
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello ${data.name},",style:
                        GoogleStyle.boldTextFieldStyle()
                        ),
                        GestureDetector(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                           },
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.only(right:20,left:5,top: 5),
                                decoration: BoxDecoration(
                                    color: Pallete.message1,
                                    borderRadius: BorderRadius.circular(7)
                                ),
                                child: const Icon(Icons.shopping_cart_outlined,color: Pallete.whiteColor,),

                              ),
                              CircleAvatar(
                                radius: 11,
                                backgroundColor: Pallete.message6,
                               child:   Text(cartLength.toString(),style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Pallete.whiteColor,
                                    fontWeight: FontWeight.w500
                                ),),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text("Delicious Food",style:
                    GoogleStyle.headlineTextFieldStyle()
                    ),
                    Text("Discover and Get Great Food",style:
                    GoogleStyle.lightTextFieldStyle()
                    ),
                    SizedBox(height: 10,),
                    CarouselSlider.builder(
                      itemCount: ImageConstant.images.length ,
                      itemBuilder:(context, index, realIndex) {
                        return Container(
                          margin: EdgeInsets.only(right: 20),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            color: Pallete.message6,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage(ImageConstant.images[index],),fit: BoxFit.fill)
                          ),

                        );
                      },
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(seconds: 2),
                          viewportFraction:1,
                          autoPlayCurve: Curves.easeIn
                      ),),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(ImageConstant.category.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              changeSelectIndex(index);
                            },
                            child: Material(
                              elevation: 5,
                              color: selectIndex==index?Pallete.message6:Pallete.message4,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  ImageConstant.category[index],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  color: selectIndex==index?Pallete.whiteColor:Pallete.blackColor,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 20,),
                  streamFoodAsync.when(
                       data: (data) =>
                           SizedBox(
                             height: 250,
                             child: ListView.separated(
                               itemCount: data.length,
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (context, index) {
                                 final product = data[index];
                                 return ProductTile(productModel: product,);
                               }, separatorBuilder: (BuildContext context, int index) {
                               return SizedBox(width: 20,);
                             },),
                           ),
                       error: (error, stackTrace) => ErrorText(error: error.toString()),
                       loading: () => Loader(),
                   ),
                  ],
                ),
              )
            ],
          ),

      );
    }
  }
  