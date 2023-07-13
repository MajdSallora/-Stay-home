import 'package:driver_project/app/deliver_details/presentation/ui/screen/deliver_details.dart';
import 'package:driver_project/common/utiles/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../const/enum.dart';

class DeliverCard extends StatelessWidget {
  const DeliverCard({Key? key,required this.type,required this.isRated,required this.isDone}) : super(key: key);

  final Deliver type;
  final bool isRated;
  final bool isDone;

  factory DeliverCard.person({required bool isRated,required bool isDone}) =>  DeliverCard(type: Deliver.person,isRated: isRated,isDone: isDone,);
  factory DeliverCard.goods({required bool isRated,required bool isDone}) =>  DeliverCard(type: Deliver.goods,isRated: isRated,isDone: isDone);
  factory DeliverCard.staff({required bool isRated,required bool isDone}) =>  DeliverCard(type: Deliver.staff,isRated: isRated,isDone: isDone);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DeliverDetails(type: type,isView: false,inDelivery: false,isDone:isDone)));
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 12.r,horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              deliverTitle(),
              SizedBox(height: 6.r,),
              Row(
                children: [
                  SvgPicture.asset(Assets.assetsPerson),
                  SizedBox(width: 4.w,),
                  Text("MAJD"),
                ],
              ),
              SizedBox(height: 6.r,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                    children: [
                      SvgPicture.asset(Assets.assetsMoney),
                      SizedBox(width: 4.w,),
                      const Text("  500 ل.س",textDirection: TextDirection.rtl,),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.date_range),
                      Text(DateTime.now().toDateOnly())
                    ],
                  )
                ],
              ),
              SizedBox(height: 6.r,),
              Row(
                children: [
                  SvgPicture.asset(Assets.assetsFirstPoint),
                  SizedBox(width: 4.r,),
                  Text("حلب الجديدة"),
                ],
              ),
              SizedBox(height: 6.r,),
              Row(
                children: [
                  SvgPicture.asset(Assets.assetsSecondPoint),
                  SizedBox(width: 4.r,),
                  Text("سيف الدولة"),
                ],
              ),
              const Divider(),
             isRated ? Center(
               child: RatingBar.builder(
                 initialRating: 3,
                 minRating: 1,
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
             ) :const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("View Details"),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget deliverTitle (){
    switch(type){
      case Deliver.goods:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsVan),
            SizedBox(width: 4.w,),
            Text("توصيل بضائع")
          ],
        );
      case Deliver.staff:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsRoadStaff),
            SizedBox(width: 4.w,),
            Text("توصيل أغراض")
          ],
        );
      case Deliver.person:
        return Row(
          children: [
            SvgPicture.asset(Assets.assetsDeliverPerson),
            SizedBox(width: 4.w,),
            Text("توصيل أشخاص")
          ],
        );
    }
  }
}
