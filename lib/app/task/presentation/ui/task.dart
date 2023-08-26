import 'package:driver_project/app/deliver_details/model/deliver_details_model.dart';
import 'package:driver_project/app/task/presentation/state/bloc/task_bloc.dart';
import 'package:driver_project/common/const/colors.dart';
import 'package:driver_project/common/constant/src/enum.dart';
import 'package:driver_project/common/core/result_builder/result_builder.dart';
import 'package:driver_project/common/imports/imports.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/deliver_card.dart';
import '../../../deliver_details/presentation/ui/screen/deliver_details.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<TaskBloc>()
        ..add(GetAllAsigned())
        ..add(GetDeliveredOrder()),
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Text("الطلبات الموكلة إلي"),
                  Text("قيد التوصيل"),
                ],
              ),
              SizedBox(
                height: 8.r,
              ),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  return Expanded(
                    child: TabBarView(
                      children: [
                        RefreshIndicator(
                          onRefresh: () async {
                            return await Future.delayed(Duration(seconds: 0), () {
                              context.read<TaskBloc>().add(GetAllAsigned());
                            });
                          },
                          child: ResultBuilder(
                            success: (data) {
                              var compineData = [...data.deliveryOrder, ...data.passengerOrder, ...data.shippingOrder];
                              compineData.sort(
                                (a, b) => a.date.compareTo(b.date),
                              );
                              return compineData.isEmpty
                                  ? SizedBox(
                                      child: ListView(
                                        children: const [
                                          SizedBox(
                                            child: Center(
                                              child: Text('لا يوجد لديك أي طلبات موكلة إليك'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: compineData.length,
                                      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                                      itemBuilder: (context, index) {
                                        return DeliverCard(
                                          inDelevirey: false,
                                          type: compineData[index].type,
                                          isRated: false,
                                          isDone: false,
                                          customer: compineData[index].customer,
                                          date: compineData[index].date,
                                          coast: '${compineData[index].coast}',
                                          source: compineData[index].source,
                                          destination: compineData[index].destination,
                                          id: compineData[index].id,
                                        );
                                      },
                                    );
                            },
                            error: (message) => SizedBox(),
                            init: () => SizedBox(),
                            loading: () => const Center(child: CircularProgressIndicator()),
                            result: state.assignedTasks,
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: () async {
                            return await Future.delayed(Duration.zero, () {
                              context.read<TaskBloc>().add(GetDeliveredOrder());
                            });
                          },
                          child: ListView(
                            children: [
                              ResultBuilder(
                                error: (message) => const Center(
                                  child: Text('حدث خطأ ما'),
                                ),
                                init: () => const SizedBox(),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                result: state.deliverTask,
                                success: (data) {
                                  DeliverDetailModel? deliverTask;
                                  OrderType type = OrderType.delivery;
                                  if (data.passengerOrder != null) {
                                    deliverTask = data.passengerOrder;
                                    type = OrderType.passenger;
                                  } else if (data.deliveryOrder != null) {
                                    deliverTask = data.deliveryOrder;
                                    type = OrderType.delivery;
                                  } else if (data.shippingOrder != null) {
                                    deliverTask = data.shippingOrder;
                                    type = OrderType.shipping;
                                  }

                                  if (deliverTask == null) {
                                    return const Center(
                                      child: Text('لا يوجد لديك طلبات قيد التوصيل'),
                                    );
                                  }
                                  return Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: DeliverDetails(
                                      isView: true,
                                      inDelivery: true,
                                      id: deliverTask.id,
                                      isDone: false,
                                      type: type,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
