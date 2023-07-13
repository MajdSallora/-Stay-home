import 'package:driver_project/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/deliver_card.dart';
import '../../../deliver_details/presentation/ui/screen/deliver_details.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Text("الطلبات المقيّمة"),
              Text("الطلبات التي تم توصيلها"),
            ]),
            SizedBox(
              height: 8.r,
            ),
            Expanded(
              child: TabBarView(children: [
                ListView.builder(
                  itemCount: 20,
                  padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                  itemBuilder: (context, index) {
                    return index % 2 == 0
                        ? DeliverCard.goods(isRated: true,isDone: true,)
                        : index % 3 == 0
                            ? DeliverCard.staff(isRated: true,isDone: true)
                            : DeliverCard.person(isRated: true,isDone: true);
                  },
                ),
                ListView.builder(
                  itemCount: 20,
                  padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                  itemBuilder: (context, index) {
                    return index % 2 == 0
                        ? DeliverCard.goods(isRated: false,isDone: true)
                        : index % 3 == 0
                        ? DeliverCard.staff(isRated: false,isDone: true)
                        : DeliverCard.person(isRated: false,isDone: true);
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
