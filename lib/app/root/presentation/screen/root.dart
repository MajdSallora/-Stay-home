import 'package:driver_project/app/acheviment/presentation/ui/achivement.dart';
import 'package:driver_project/app/profile/presentation/ui/profile.dart';
import 'package:driver_project/app/root/presentation/widget/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/assets.dart';
import '../../../task/presentation/ui/task.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:  NavRoot(
          onTap: (i){
            controller.jumpToPage(i);
          },
        ),
        body: Column(
          children: [
            SizedBox(height: 24.h,),
            SvgPicture.asset(Assets.assetsRoad),
            SizedBox(height: 12.h,),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: const [
                  AchievementScreen(),
                  TaskScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
