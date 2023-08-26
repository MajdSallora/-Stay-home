import 'package:driver_project/app/acheviment/state/bloc/acheviment_bloc.dart';
import 'package:driver_project/common/const/colors.dart';
import 'package:driver_project/common/core/result_builder/result_builder.dart';
import 'package:driver_project/common/imports/imports.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/deliver_card.dart';
import '../../../deliver_details/presentation/ui/screen/deliver_details.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AchevimentBloc>()
        ..add(GetAllAcheviment())
        ..add(GetAllDelivered()),
      child: Scaffold(
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
              BlocBuilder<AchevimentBloc, AchevimentState>(
                builder: (context, state) {
                  return Expanded(
                    child: TabBarView(
                      children: [
                        RefreshIndicator(
                          onRefresh: () async {
                            return await Future.delayed(Duration(seconds: 0), () {
                              context.read<AchevimentBloc>().add(GetAllAcheviment());
                            });
                          },
                          child: ResultBuilder(
                            error: (message) => const Center(child: Text('حدث خطأ ما')),
                            init: () => SizedBox(),
                            loading: () => const Center(child: CircularProgressIndicator()),
                            result: state.achevimentTasks,
                            success: (data) {
                              var compineData = [...data.deliveryOrder, ...data.passengerOrder, ...data.shippingOrder];
                              compineData.sort(
                                (a, b) => b.date.compareTo(a.date),
                              );
                              return compineData.isEmpty
                                  ? const Column(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text('لا يوجد لديك أي طلبات تم توصيلها'),
                                          ),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      itemCount: compineData.length,
                                      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                                      itemBuilder: (context, index) {
                                        return DeliverCard(
                                          rating: double.parse('${compineData[index].star}'),
                                          inDelevirey: true,
                                          type: compineData[index].type,
                                          isRated: true,
                                          isDone: true,
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
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: () async {
                            return await Future.delayed(Duration(seconds: 0), () {
                              context.read<AchevimentBloc>().add(GetAllDelivered());
                            });
                          },
                          child: ResultBuilder(
                            error: (message) => const Center(child: Text('حدث خطأ ما')),
                            init: () => SizedBox(),
                            loading: () => const Center(child: CircularProgressIndicator()),
                            result: state.deliveredTasks,
                            success: (data) {
                              var compineData = [...data.deliveryOrder, ...data.passengerOrder, ...data.shippingOrder];
                              compineData.sort(
                                (a, b) => b.date.compareTo(a.date),
                              );
                              return compineData.isEmpty
                                  ? SizedBox(
                                      child: ListView(
                                        children: const [
                                          SizedBox(
                                            child: Center(
                                              child: Text('لا يوجد لديك أي طلبات مقيمة'),
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
                                          isEvaluated: compineData[index].isEvaluated,
                                          inDelevirey: true,
                                          type: compineData[index].type,
                                          isRated: false,
                                          isDone: true,
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
