import 'package:driver_project/app/login/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:driver_project/common/const/colors.dart';
import 'package:driver_project/common/imports/imports.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:driver_project/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../root/presentation/screen/root.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  var _email = "";
  var _password = "";
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthBloc>(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status.isSuccess()) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RootScreen()));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _form,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: SvgPicture.asset(
                            Assets.assetsLoginHeader,
                            fit: BoxFit.fitWidth,
                          )),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " أهلا بك!👀",
                                style: TextStyle(fontSize: 18.sp, color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text(
                                " يرجى ملء المعلومات المطلوبة لتسجيل الدخول",
                                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              TextFormField(
                                textAlign: TextAlign.end,
                                textDirection: TextDirection.rtl,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: "بريد الالكتروني",
                                    suffixIcon: Icon(
                                      Icons.alternate_email,
                                      color: AppColors.grey,
                                    )),
                                onSaved: (value) {
                                  _email = value!;
                                },
                                validator: (value) {
                                  if (value == '') {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              StatefulBuilder(builder: (context, set) {
                                return TextFormField(
                                  textAlign: TextAlign.end,
                                  textDirection: TextDirection.rtl,
                                  obscureText: obscureText,
                                  decoration: InputDecoration(
                                      hintText: "كلمة السر",
                                      suffixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.grey,
                                      ),
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          obscureText = !obscureText;
                                          set(() {});
                                        },
                                        child: Icon(obscureText ? Icons.visibility : Icons.visibility_off_outlined),
                                      )),
                                  onSaved: (value) {
                                    _password = value!;
                                  },
                                  validator: (value) {
                                    if (value == '') {
                                      return 'هذا الحقل مطلوب';
                                    }
                                    if (value!.length < 4) {
                                      return 'يجب أن تكون على الاقل بطول 4';
                                    }
                                    return null;
                                  },
                                );
                              }),
                              SizedBox(
                                height: 16.h,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    final isValid = _form.currentState!.validate();
                                    if (!isValid) {
                                      return;
                                    }
                                    _form.currentState!.save();
                                    context.read<AuthBloc>().add(Login(email: _email, password: _password));
                                  },
                                  child: const Text("تسجيل الدخول")),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: SvgPicture.asset(
                            Assets.assetsBottomWave,
                            fit: BoxFit.fill,
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
