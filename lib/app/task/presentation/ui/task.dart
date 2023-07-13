import 'package:driver_project/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/deliver_card.dart';
import '../../../deliver_details/presentation/ui/screen/deliver_details.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Text("الطلبات الموكلة إلي"),
              Text("قيد التوصيل"),
            ]),
            SizedBox(
              height: 8.r,
            ),
            Expanded(
              child: TabBarView(
                  children: [
                ListView.builder(
                  itemCount: 20,
                  padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                  itemBuilder: (context, index) {
                    return index % 2 == 0
                        ? DeliverCard.goods(isRated: false,isDone: false)
                        : index % 3 == 0
                            ? DeliverCard.staff(isRated: false,isDone: false)
                            : DeliverCard.person(isRated: false,isDone: false,);
                  },
                ),
               SingleChildScrollView(child: Padding(
                 padding: EdgeInsets.all(16.r),
                 child: DeliverDetails.person(isView: true,inDelivery: true,),
               ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
