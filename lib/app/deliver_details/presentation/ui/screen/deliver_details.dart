import 'package:driver_project/app/deliver_details/presentation/state/bloc/deliver_detail_bloc.dart';
import 'package:driver_project/common/constant/src/enum.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/result_builder/result_builder.dart';
import 'package:driver_project/common/imports/imports.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:driver_project/common/utiles/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../generated/assets.dart';

class DeliverDetails extends StatelessWidget {
  const DeliverDetails({
    Key? key,
    required this.type,
    required this.isView,
    required this.inDelivery,
    required this.isDone,
    required this.id,
  }) : super(key: key);
  final bool isView;
  final bool inDelivery;
  final bool isDone;
  final String id;

  final OrderType type;

  @override
  Widget build(BuildContext context) {
    return isView
        ? body(context, isView, inDelivery, isDone)
        : SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16.r),
                child: body(context, isView, inDelivery, isDone),
              ),
            ),
          );
  }

  Widget body(BuildContext context, bool isView, bool inDelivery, bool isDone) {
    return BlocProvider.value(
      value: getIt<DeliverDetailBloc>()..add(GetOrderById(id: id, type: type)),
      child: SingleChildScrollView(
        child: BlocBuilder<DeliverDetailBloc, DeliverDetailState>(
          builder: (context, state) {
            return ResultBuilder(
              error: (message) => const Center(
                child: Text('حدث خطأ ما'),
              ),
              init: () => const SizedBox(),
              loading: () => SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
              result: state.order,
              success: (data) => Column(
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
                                          Text(data.customer),
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
                                              Text(
                                                "  ${data.coast} ل.س",
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
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
                                          Text(data.source),
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
                                          Text(data.destination),
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
                                    Text(data.date.toDateOnly()),
                                    SizedBox(
                                      height: 2.r,
                                    ),
                                    Text(data.date.toTimeOnly()),
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
                                    Text("${data.distance} Km"),
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
                          if (data.cartModel != null && data.cartModel!.isNotEmpty)
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(" :سلة الزبون تتضمن المنتجات التالية"),
                              ],
                            ),
                          if (data.cartModel != null && data.cartModel!.isNotEmpty)
                            SizedBox(
                              height: 3.h,
                            ),
                          if (data.cartModel != null && data.cartModel!.isNotEmpty)
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      for (int i = 0; i < data.cartModel!.length; i++) Text('${data.cartModel![i].quantity}'),
                                    ],
                                  ),
                                  VerticalDivider(
                                    color: AppColors.primary,
                                    thickness: 2,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0; i < data.cartModel!.length; i++)
                                        Column(
                                          children: [
                                            CartItem(
                                              image: '${AppUrl.baseUrl}/${data.cartModel![i].imageUrl}',
                                              name: data.cartModel![i].name,
                                            ),
                                            SizedBox(
                                              height: 5.r,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            ),
                          if (data.cartModel != null && data.cartModel!.isNotEmpty) Divider(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (data.note != null || data.weight != null || data.numberOfPassenger != null)
                                  Text("معلومات إضافية", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (data.numberOfPassenger != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('عدد الركاب: ${data.numberOfPassenger}',
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primary)),
                                            SizedBox(
                                              width: 4.r,
                                            ),
                                            const Icon(Icons.groups),
                                          ],
                                        ),
                                      if (data.weight != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("إجمالي الوزن ${data.weight} كيلو",
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primary)),
                                            SizedBox(
                                              width: 4.r,
                                            ),
                                            SvgPicture.asset(Assets.assetsBox),
                                          ],
                                        ),
                                      if (data.note != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "ملاحظات الزبون: ${data.note}",
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primary),
                                            ),
                                            SizedBox(
                                              width: 4.r,
                                            ),
                                            SvgPicture.asset(Assets.assetsCatagorey),
                                          ],
                                        ),
                                      if (data.note != null || data.weight != null) Divider(),
                                      if (data.note != null || data.weight != null)
                                        SizedBox(
                                          height: 4.r,
                                        ),
                                      Center(
                                          child: inDelivery && !isDone
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        context.read<DeliverDetailBloc>().add(CompleteOrder(id: id));
                                                      },
                                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
                                                      child: const Text("إنهاء الرحلة"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        String cancelBy = '';
                                                        String reason = '';
                                                        showDialog(
                                                          context: context,
                                                          builder: (_) {
                                                            return SimpleDialog(
                                                              contentPadding: EdgeInsets.all(16.r),
                                                              children: [
                                                                Center(
                                                                    child: Text(
                                                                  "الإلغاء",
                                                                  style: Theme.of(context).textTheme.bodyLarge,
                                                                )),
                                                                const Divider(),
                                                                SizedBox(
                                                                  height: 8.r,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    const Text(':إلغاء من قبل'),
                                                                  ],
                                                                ),
                                                                StatefulBuilder(
                                                                  builder: (context, setState) => SizedBox(
                                                                    height: 70.h,
                                                                    child: InputDecorator(
                                                                      decoration: InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(23.r))),
                                                                      ),
                                                                      child: DropdownButtonHideUnderline(
                                                                        child: Directionality(
                                                                          textDirection: TextDirection.rtl,
                                                                          child: DropdownButton(
                                                                            value: cancelBy.isEmpty ? null : cancelBy,
                                                                            items: const [
                                                                              DropdownMenuItem(
                                                                                value: 'Customer',
                                                                                child: Text('الزبون'),
                                                                              ),
                                                                              DropdownMenuItem(
                                                                                value: 'Driver',
                                                                                child: Text('السائق'),
                                                                              ),
                                                                            ],
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                cancelBy = value!;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                TextField(
                                                                  onChanged: (value) => reason = value,
                                                                  textDirection: TextDirection.rtl,
                                                                ),
                                                                SizedBox(
                                                                  height: 16.r,
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    if (reason.isNotEmpty && cancelBy.isNotEmpty) {
                                                                      context
                                                                          .read<DeliverDetailBloc>()
                                                                          .add(CancelOrder(id: id, cancelBy: cancelBy, reason: reason));
                                                                    }
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("إلغاء"),
                                                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text("إلغاء"),
                                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                    ),
                                                  ],
                                                )
                                              : isDone
                                                  ? const SizedBox()
                                                  : Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            context.read<DeliverDetailBloc>().add(AcceptOrder(id: id));
                                                          },
                                                          child: Text("ابدأ التوصيل"),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            String cancelBy = '';
                                                            String reason = '';
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return SimpleDialog(
                                                                  contentPadding: EdgeInsets.all(16.r),
                                                                  children: [
                                                                    Center(
                                                                        child: Text(
                                                                      "الإلغاء",
                                                                      style: Theme.of(context).textTheme.bodyLarge,
                                                                    )),
                                                                    const Divider(),
                                                                    SizedBox(
                                                                      height: 8.r,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        const Text(':إلغاء من قبل'),
                                                                      ],
                                                                    ),
                                                                    StatefulBuilder(
                                                                      builder: (context, setState) => SizedBox(
                                                                        height: 70.h,
                                                                        child: InputDecorator(
                                                                          decoration: InputDecoration(
                                                                            border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(23.r))),
                                                                          ),
                                                                          child: DropdownButtonHideUnderline(
                                                                            child: Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: DropdownButton(
                                                                                value: cancelBy.isEmpty ? null : cancelBy,
                                                                                items: const [
                                                                                  DropdownMenuItem(
                                                                                    value: 'Customer',
                                                                                    child: Text('الزبون'),
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 'Driver',
                                                                                    child: Text('السائق'),
                                                                                  ),
                                                                                ],
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    cancelBy = value!;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.h,
                                                                    ),
                                                                    TextField(
                                                                      onChanged: (value) => reason = value,
                                                                      textDirection: TextDirection.rtl,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 16.r,
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed: () {
                                                                        if (reason.isNotEmpty && cancelBy.isNotEmpty) {
                                                                          context
                                                                              .read<DeliverDetailBloc>()
                                                                              .add(CancelOrder(id: id, cancelBy: cancelBy, reason: reason));
                                                                        }
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text("إلغاء"),
                                                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Text("إلغاء"),
                                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                        ),
                                                      ],
                                                    ))
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget deliverTitle() {
    switch (type) {
      case OrderType.shipping:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsVan),
            SizedBox(
              width: 4.w,
            ),
            Text("توصيل بضائع")
          ],
        );
      case OrderType.delivery:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsRoadStaff),
            SizedBox(
              width: 4.w,
            ),
            Text("توصيل أغراض")
          ],
        );
      case OrderType.passenger:
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

class CartItem extends StatelessWidget {
  final String name;
  final String image;

  const CartItem({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
        SizedBox(
          width: 5.w,
        ),
        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(50.r),
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
