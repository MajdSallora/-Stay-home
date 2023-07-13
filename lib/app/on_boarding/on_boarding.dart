import 'package:driver_project/common/const/colors.dart';
import 'package:driver_project/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../login/presentation/ui/login.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      skipStyle: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.primary),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: AppColors.secondary
      ),
      doneStyle: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.primary),
      ),
      pages: [
        page(title: "Start your ride",subtitle: "ابدأ في تخطيط طلباتك اليومية ووفر الوقت على الطريق",image: Assets.assetsOnbaord1,context: context),
        page(title: "Join Us As Driver!",subtitle: "قم بالقيادة بذكاء وانضم إلى شبكة سائقينا  الضخمة  ",image: Assets.assetsOnbaord2,context: context),
        page(title: "Stay Home On Ride",subtitle: "",image: Assets.assetsOnbaord3,context: context),
      ],
      showSkipButton: true,
      showNextButton: false,
      skip:  Text("تخطي",style: TextStyle(color:AppColors.white),),
      done:  Text("ابدأ الأن",style: TextStyle(color:AppColors.white)),
      onDone: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
  }
  PageViewModel page({required String title,required String subtitle,required String image,required BuildContext context}){
    return PageViewModel(
      title: title,
      decoration: PageDecoration(
        titleTextStyle: TextStyle(color: AppColors.primary,fontSize: 18.sp,fontWeight: FontWeight.bold),
        bodyAlignment: Alignment.bottomCenter,
        imageFlex: 3,

      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(subtitle,textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium)),
      ),
      image: Center(child: SvgPicture.asset(image)),
    );
  }
}
