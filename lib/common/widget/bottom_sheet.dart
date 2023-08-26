import 'package:driver_project/common/const/colors.dart';

import '../imports/imports.dart';

showCustomBottomSheet({required  BuildContext context,required Widget child,}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24.r),
      topRight: Radius.circular(24.r),
    )),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8.r, right: 8.r, top: 8.r),
              width: 120.w,
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.r, right: 8.r, top: 8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
