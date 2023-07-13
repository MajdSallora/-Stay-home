import 'package:driver_project/app/profile/presentation/state/profile_bloc.dart';
import 'package:driver_project/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:reactive_forms/reactive_forms.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ProfileBloc();
    return BlocProvider.value(
      value: bloc,
      child: ReactiveForm(
        formGroup: ProfileBloc.form,
        child: Scaffold(
         body: Padding(
           padding: EdgeInsets.all(16.r),
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Card(
                   elevation: 3,
                   child: Padding(
                     padding: EdgeInsets.all(16.r),
                     child: Column(
                       children: [
                         input(controller: ProfileBloc.username),
                         input(controller: ProfileBloc.email),
                         input(controller: ProfileBloc.phoneNumber),
                         input(controller: ProfileBloc.birthdate),
                       ],
                     ),
                   ),
                 ),
                 SizedBox(height: 16.r,),
                 ElevatedButton(onPressed: (){
                   bloc.add(ModifyProfile());
                 }, child: const Text("حفظ"))
               ],
             ),
           ),
         ),
        ),
      ),
    );
  }

  Widget input({required String controller}){
    final String title =  controller == ProfileBloc.email ? "البريد الالكترني" : controller == ProfileBloc.birthdate ? "تاريخ الميلاد" : controller == ProfileBloc.username ? "الاسم الكامل" : "رقم الهاتف";
    final IconData icon =  controller == ProfileBloc.email ? Icons.email_outlined : controller == ProfileBloc.birthdate ? Icons.date_range : controller == ProfileBloc.username ? Icons.person :Icons.phone;
    final isBirthDate = controller == ProfileBloc.birthdate;
    final isPhoneNumber = controller == ProfileBloc.phoneNumber;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.r),
            child: Text(title),
          ),
          SizedBox(height: 6.r,),
         !isBirthDate ? ReactiveTextField(
            formControlName: controller,
            keyboardType: isPhoneNumber ? TextInputType.number : TextInputType.text,
            validationMessages: {
              ValidationMessage.required : (_) => "هذا الحقل مطلوب",
              ValidationMessage.email : (_) => "يرجى كتابة الصيغة على الشكل الاتي example@dev.com",
            },
            decoration: InputDecoration(
              hintText: title,
              prefixIcon:  Icon(icon,color: AppColors.primary,)
            ),
          ) : ReactiveDatePicker<DateTime>(
           formControlName: ProfileBloc.birthdate,
           firstDate: DateTime(1985),
           lastDate: DateTime(2030),
           builder: (context, picker, child) {
             Widget suffix = InkWell(
               onTap: () {
                 picker.control.value = null;
               },
               child: const Icon(Icons.clear),
             );

             if (picker.value == null) {
               suffix = const Icon(Icons.calendar_today);
             }

             return ReactiveTextField(
               onTap: (_) {
                   picker.showPicker();
               },
               validationMessages: {
                 ValidationMessage.required : (_) => "هذا الحقل مطلوب",
               },
               valueAccessor: DateTimeValueAccessor(
                 dateTimeFormat: intl.DateFormat('dd MMM yyyy'),
               ),
               formControlName: ProfileBloc.birthdate,
               readOnly: true,
               decoration: InputDecoration(
                   hintText: title,
                   prefixIcon:  Icon(icon,color: AppColors.primary,)
               ),
             );
           },
         ),
          SizedBox(height: 16.r,),

        ],
      ),
    );
  }
}
