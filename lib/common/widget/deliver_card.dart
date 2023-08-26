// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:driver_project/common/constant/src/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:driver_project/app/deliver_details/presentation/ui/screen/deliver_details.dart';
import 'package:driver_project/common/utiles/date_converter.dart';

import '../../generated/assets.dart';

class DeliverCard extends StatelessWidget {
  const DeliverCard({
    Key? key,
    required this.type,
    required this.isRated,
    required this.isDone,
    required this.customer,
    required this.date,
    required this.coast,
    required this.source,
    required this.destination,
    required this.id,
    this.inDelevirey = false,
    this.rating,
    this.isEvaluated,
  }) : super(key: key);

  final OrderType type;
  final bool isRated;
  final bool isDone;
  final String customer;
  final DateTime date;
  final String coast;
  final String source;
  final String destination;
  final String id;
  final bool inDelevirey;
  final double? rating;
  final bool? isEvaluated;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DeliverDetails(
                      type: type,
                      isView: false,
                      inDelivery: inDelevirey,
                      isDone: isDone,
                      id: id,
                    )));
      },
      child: Card(
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
              Row(
                children: [
                  SvgPicture.asset(Assets.assetsPerson),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(customer),
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
                        "  $coast ل.س",
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  Row(
                    children: [const Icon(Icons.date_range), Text(date.toDateOnly())],
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
                  Text(source),
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
                  Text(destination),
                ],
              ),
              if (isEvaluated == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
              const Divider(),
              isRated
                  ? Center(
                      child: RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: rating ?? 0,
                        minRating: 0,
                        itemSize: 22.r,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text("View Details"), Icon(Icons.arrow_forward_ios)],
                    )
            ],
          ),
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
