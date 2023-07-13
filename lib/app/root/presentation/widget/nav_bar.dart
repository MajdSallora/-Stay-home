import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:driver_project/common/const/colors.dart';
import 'package:flutter/material.dart';

class NavRoot extends StatelessWidget {
  const NavRoot({Key? key,required this.onTap}) : super(key: key);
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: AppColors.white,
      activeColor: AppColors.primary,
      color: AppColors.grey,
      items: const [
        TabItem(icon: Icons.task, title: 'الإنجاز'),
        TabItem(icon: Icons.drive_eta_outlined, title: 'المهام'),
        TabItem(icon: Icons.person, title: 'البروفايل'),
      ],
      onTap: onTap,
    );
  }


}
