import 'package:driver_project/app/login/infrastructure/data_source/local/auth_local.dart';
import 'package:driver_project/app/profile/presentation/state/profile_bloc.dart';
import 'package:driver_project/app/profile/presentation/ui/widget/profile_car.dart';
import 'package:driver_project/common/const/colors.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/result_builder/result_builder.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:driver_project/common/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:reactive_forms/reactive_forms.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<ProfileBloc>();
    return BlocProvider.value(
      value: bloc
        ..add(GetProfile())
        ..add(GetAllVehcileType()),
      child: ReactiveForm(
        formGroup: ProfileBloc.form,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: SizedBox(
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
                            BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                return ResultBuilder(
                                  error: (message) => SizedBox(),
                                  init: () => SizedBox(),
                                  loading: () => CircularProgressIndicator(),
                                  result: state.vehicleType,
                                  success: (data) => SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('تفاصيل السيارة'),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showCustomBottomSheet(
                                              context: context,
                                              child: Column(
                                                children: [
                                                  const RSizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            final image = ImagePicker();
                                                            final imageVal = await image.pickImage(source: ImageSource.gallery);
                                                            if (context.mounted) {
                                                              context.read<ProfileBloc>().add(ChangeImage(image: imageVal!.path));
                                                              Navigator.pop(context);
                                                            }
                                                          },
                                                          child: Text('من المعرض'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const RSizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            final image = ImagePicker();
                                                            final imageVal = await image.pickImage(source: ImageSource.camera);
                                                            if (context.mounted) {
                                                              context.read<ProfileBloc>().add(ChangeImage(image: imageVal!.path));
                                                              Navigator.pop(context);
                                                            }
                                                          },
                                                          child: Text('باستخدام الكاميرا'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const RSizedBox(height: 16),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 138.r,
                                            height: 138.r,
                                            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
                                            child: ProfileCar(imagePath: '${ProfileBloc.form.control(ProfileBloc.carImage).value}'),
                                            // child: Image.network('${AppUrl.baseUrl}/${ProfileBloc.form.control(ProfileBloc.carImage).value}'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: ReactiveDropdownField(
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                  formControlName: ProfileBloc.carType,
                                                  items: data
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e.id,
                                                          child: Text(e.name),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                            const Text(" :النوع"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7.r,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: ReactiveTextField(
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                  formControlName: ProfileBloc.carName,
                                                ),
                                              ),
                                            ),
                                            const Text(" :الاسم"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7.r,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: ReactiveTextField(
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                  formControlName: ProfileBloc.carNum,
                                                ),
                                              ),
                                            ),
                                            const Text(" :الرقم"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.r,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bloc.add(ModifyProfile());
                        },
                        child: const Text("حفظ"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget input({required String controller}) {
    final String title = controller == ProfileBloc.email
        ? "البريد الالكترني"
        : controller == ProfileBloc.birthdate
            ? "تاريخ الميلاد"
            : controller == ProfileBloc.username
                ? "الاسم الكامل"
                : "رقم الهاتف";
    final IconData icon = controller == ProfileBloc.email
        ? Icons.email_outlined
        : controller == ProfileBloc.birthdate
            ? Icons.date_range
            : controller == ProfileBloc.username
                ? Icons.person
                : Icons.phone;
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
          SizedBox(
            height: 6.r,
          ),
          !isBirthDate
              ? ReactiveTextField(
                  formControlName: controller,
                  keyboardType: isPhoneNumber ? TextInputType.number : TextInputType.text,
                  validationMessages: {
                    ValidationMessage.required: (_) => "هذا الحقل مطلوب",
                    ValidationMessage.email: (_) => "يرجى كتابة الصيغة على الشكل الاتي example@dev.com",
                  },
                  decoration: InputDecoration(
                      hintText: title,
                      prefixIcon: Icon(
                        icon,
                        color: AppColors.primary,
                      )),
                )
              : ReactiveDatePicker<DateTime>(
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
                        ValidationMessage.required: (_) => "هذا الحقل مطلوب",
                      },
                      valueAccessor: DateTimeValueAccessor(
                        dateTimeFormat: intl.DateFormat('dd MMM yyyy'),
                      ),
                      formControlName: ProfileBloc.birthdate,
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: title,
                          prefixIcon: Icon(
                            icon,
                            color: AppColors.primary,
                          )),
                    );
                  },
                ),
          SizedBox(
            height: 16.r,
          ),
        ],
      ),
    );
  }
}
