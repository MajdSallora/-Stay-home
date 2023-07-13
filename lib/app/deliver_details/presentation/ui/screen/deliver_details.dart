import 'package:driver_project/common/utiles/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/const/enum.dart';
import '../../../../../generated/assets.dart';

class DeliverDetails extends StatelessWidget {
  const DeliverDetails({Key? key, required this.type, required this.isView, required this.inDelivery,required this.isDone}) : super(key: key);
  final bool isView;
  final bool inDelivery;
  final bool isDone;

  final Deliver type;

  factory DeliverDetails.person({required bool isView, required bool inDelivery}) => DeliverDetails(
        type: Deliver.person,
        isView: isView,
        inDelivery: inDelivery,
    isDone: false,
      );

  factory DeliverDetails.goods({required bool isView, required bool inDelivery}) =>
      DeliverDetails(type: Deliver.goods, isView: isView, inDelivery: inDelivery,isDone: false,);

  factory DeliverDetails.staff({required bool isView, required bool inDelivery}) =>
      DeliverDetails(type: Deliver.staff, isView: isView, inDelivery: inDelivery,isDone: false,);

  @override
  Widget build(BuildContext context) {
    return isView
        ? body(context, isView, inDelivery,isDone)
        : SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16.r),
                child: body(context, isView, inDelivery,isDone),
              ),
            ),
          );
  }

  Widget body(BuildContext context, bool isView, bool inDelivery,bool isDone) {
    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),
        isView ? const SizedBox() : SvgPicture.asset(Assets.assetsRoad),
        isView
            ? const SizedBox()
            : SizedBox(
                height: 12.h,
              ),
        Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                deliverTitle(),
                SizedBox(
                  height: 6.r,
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalDivider(color: AppColors.primary, width: 5, thickness: 2),
                      SizedBox(
                        width: 8.r,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(Assets.assetsPerson),
                                SizedBox(
                                  width: 4.w,
                                ),
                                const Text("MAJD"),
                              ],
                            ),
                            SizedBox(
                              height: 6.r,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(Assets.assetsMoney),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    const Text(
                                      "  500 ل.س",
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [const Icon(Icons.date_range), Text(DateTime.now().toDateOnly())],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 6.r,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(Assets.assetsFirstPoint),
                                SizedBox(
                                  width: 4.r,
                                ),
                                Text("حلب الجديدة"),
                              ],
                            ),
                            SizedBox(
                              height: 6.r,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(Assets.assetsSecondPoint),
                                SizedBox(
                                  width: 4.r,
                                ),
                                Text("سيف الدولة"),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateTime.now().toDateOnly()),
                          SizedBox(
                            height: 2.r,
                          ),
                          Text(DateTime.now().toTimeOnly()),
                          SizedBox(
                            height: 2.r,
                          ),
                          SvgPicture.asset(Assets.assetsClock),
                        ],
                      ),
                      VerticalDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("المسافة بين نقطتين"),
                          SizedBox(
                            height: 2.r,
                          ),
                          Text("16 Km"),
                          SizedBox(
                            height: 2.r,
                          ),
                          SvgPicture.asset(Assets.assetsLocationMap),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                Divider(),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      Container(
                          width: 138.r,
                          height: 138.r,
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
                          child: const FlutterLogo()),
                      VerticalDivider(
                        color: AppColors.primary,
                        thickness: 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("المركبة التي ستستلمها للرحلة"),
                          SizedBox(
                            height: 2.r,
                          ),
                          const Text("النوع: شاحنة"),
                          SizedBox(
                            height: 2.r,
                          ),
                          const Text("الأسم: هوندا"),
                          SizedBox(
                            height: 2.r,
                          ),
                          const Text("الرقم: 09929"),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("معلومات إضافية", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("إجمالي الوزن 500 كيلو", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primary)),
                                SizedBox(
                                  width: 4.r,
                                ),
                                SvgPicture.asset(Assets.assetsBox),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "ملاحظات الزبون: الرجاء عدم قرع الجرس",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primary),
                                ),
                                SizedBox(
                                  width: 4.r,
                                ),
                                SvgPicture.asset(Assets.assetsCatagorey),
                              ],
                            ),
                            Divider(),
                            SizedBox(
                              height: 4.r,
                            ),
                            Center(
                                child: inDelivery && !isDone
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text("تأكيد الطلب"),
                                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                showDialog(context: context, builder: (context){
                                                  return SimpleDialog(
                                                    contentPadding: EdgeInsets.all(16.r),
                                                    children: [
                                                      Center(child: Text("سبب الإلغاء",style: Theme.of(context).textTheme.bodyLarge,)),
                                                      Divider(),
                                                      SizedBox(height: 8.r,),
                                                      const TextField(),
                                                      SizedBox(height: 16.r,),
                                                      ElevatedButton(onPressed: (){
                                                        Navigator.of(context).pop();
                                                      }, child: Text("إلغاء"),
                                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red))
                                                    ],
                                                  );
                                                });
                                              },
                                              child: Text("إلغاء"),
                                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red)),
                                        ],
                                      )
                                    : isDone ? const SizedBox() : ElevatedButton(onPressed: () {}, child: Text("ابدأ التوصيل")))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget deliverTitle() {
    switch (type) {
      case Deliver.goods:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsVan),
            SizedBox(
              width: 4.w,
            ),
            Text("توصيل بضائع")
          ],
        );
      case Deliver.staff:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsRoadStaff),
            SizedBox(
              width: 4.w,
            ),
            Text("توصيل أغراض")
          ],
        );
      case Deliver.person:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsDeliverPerson),
            SizedBox(
              width: 4.w,
            ),
            Text("توصيل أشخاص")
          ],
        );
    }
  }
}
