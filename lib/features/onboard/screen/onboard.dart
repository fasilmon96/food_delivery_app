 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/common/custom_builddot.dart';
import 'package:my_project/core/common/custom_button.dart';
import 'package:my_project/core/constant/meadiaquery_value.dart';
import 'package:my_project/core/constant/text_constant.dart';
import 'package:my_project/features/auth/screen/login_screen.dart';
import 'package:my_project/model/content_model.dart';
import 'package:my_project/theme/pallete.dart';

import '../../../core/providers/widgets.dart';

class Onboard extends ConsumerStatefulWidget {
   const Onboard({super.key});

   @override
   ConsumerState<Onboard> createState() => _OnboardState();
 }

 class _OnboardState extends ConsumerState<Onboard> {
   final PageController pageController = PageController(initialPage:0);
    void changePage(int indexChange){
     ref.read(currentIndex.notifier).state=indexChange;
   }
   @override
  void didChangeDependencies() {
     for(final content in contents){
        precacheImage(AssetImage(content.image), context);
     }
    super.didChangeDependencies();
  }
   @override
   void dispose() {
      pageController.dispose();
     super.dispose();
  }
   @override
   Widget build(BuildContext context) {
     SizeConfig.init(context);
     final width = MediaQuery.of(context).size.width;
     final selectedIndex =ref.watch(currentIndex);
     final isNext =selectedIndex==contents.length-1;
      return Scaffold(
        backgroundColor: Pallete.whiteColor,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: contents.length,
                onPageChanged:(value) {
                    changePage(value);
                } ,
                itemBuilder: (context, index) {
                  final data= contents[index];
                  return Padding(padding:const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image.asset(data.image,
                        height: SizeConfig.screenHeight*0.6,
                          width: width/1.5,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical*6,),
                        Text(data.title,style: GoogleStyle.semiBoldTextFieldStyle(),
                          textAlign: TextAlign.center,
                          ),
                        SizedBox(height: 20,),
                        Text(data.description,style: GoogleStyle.lightTextFieldStyle(),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),

                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(contents.length, (index) {
                  return BuildDot(index: index,currentIndex: selectedIndex,);
                },),
              ),
            ),
            GestureDetector(
              onTap: () {
                if(isNext){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                }else{
                  pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeOut);

                }
              },
              child: CustomButton(
                  text: isNext?"Start":"Next",
              ),
            ),
           const SizedBox(height: 10,)
          ],
        ),
      );
   }
 }
