import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/auth_local.dart';
import 'package:driver_project/app/profile/application/profile_facade.dart';
import 'package:driver_project/app/profile/domain/entities/profile_param.dart';
import 'package:driver_project/app/profile/inrastructure/model/vehicle_type.dart';
import 'package:driver_project/common/core/result_builder/result.dart';
import 'package:driver_project/common/core/user/entities/vehicle.dart';
import 'package:driver_project/common/helper/colered_print.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  static const String username = "username";
  static const String email = "email";
  static const String phoneNumber = "phoneNumber";
  static const String birthdate = "birthdate";
  static const String carType = "carType";
  static const String carName = 'carName';
  static const String carNum = 'carNum';
  static const String carImage = 'carImage';

  static FormGroup form = FormGroup({
    username: FormControl<String>(
      validators: [Validators.required],
    ),
    email: FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    phoneNumber: FormControl<String>(
      validators: [Validators.required, Validators.number],
    ),
    birthdate: FormControl<DateTime>(
      validators: [Validators.required],
    ),
    carType: FormControl<String>(
      validators: [Validators.required],
    ),
    carName: FormControl<String>(
      validators: [Validators.required],
    ),
    carNum: FormControl<String>(
      validators: [Validators.required],
    ),
    carImage: FormControl<String>(
      validators: [Validators.required],
    ),
  });

  final ProfileFacade _facade;

  ProfileBloc(final ProfileFacade facade)
      : _facade = facade,
        super(ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ModifyProfile) {
        await save(event, emit);
      } else if (event is GetProfile) {
        await getProfile(event, emit);
      } else if (event is GetAllVehcileType) {
        await getAllVehcileType(event, emit);
      } else if (event is ChangeImage) {
        form.control(carImage).value = event.image;
        emit(state.copyWith());
      }
    });
  }
  Future<void> save(ModifyProfile event, Emitter emit) async {
    if (form.valid) {
      BotToast.showLoading();
      final result = await _facade.modifyProfile(
        ProfileParam(
          fullName: form.control(username).value,
          email: form.control(email).value,
          phoneNumber: form.control(phoneNumber).value,
          birthDate: form.control(birthdate).value,
          vehicle: Vehicle(
            vehicleTypeId: form.control(carType).value,
            color: getIt<AuthLocal>().getUser()!.vehicle.color,
            number: form.control(carNum).value,
            name: form.control(carName).value,
            imageFile: form.control(carImage).value,
            maxCapacity: getIt<AuthLocal>().getUser()!.vehicle.maxCapacity,
          ),
        ),
      );
      getIt<AuthLocal>().setUser(
        getIt<AuthLocal>().getUser()!.copyWith(
              fullName: form.control(username).value,
              email: form.control(email).value,
              phoneNumber: form.control(phoneNumber).value,
              birthDate: form.control(birthdate).value,
            ),
      );
      result.fold(
        (left) => BotToast.showText(text: left),
        (right) => BotToast.showText(text: 'تم التعديل بنجاح'),
      );
      BotToast.closeAllLoading();
    } else {
      form.markAllAsTouched();
    }
  }

  getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    if (getIt<AuthLocal>().getUser() != null) {
      form.control(username).value = getIt<AuthLocal>().getUser()!.fullName;
      form.control(email).value = getIt<AuthLocal>().getUser()!.email;
      form.control(phoneNumber).value = getIt<AuthLocal>().getUser()!.phoneNumber;
      form.control(birthdate).value = getIt<AuthLocal>().getUser()!.birthDate;
      form.control(carName).value = getIt<AuthLocal>().getUser()!.vehicle.name;
      form.control(carNum).value = getIt<AuthLocal>().getUser()!.vehicle.number;
      form.control(carType).value = getIt<AuthLocal>().getUser()!.vehicle.vehicleTypeId;
      form.control(carImage).value = getIt<AuthLocal>().getUser()!.vehicle.imageFile;
    }
  }

  getAllVehcileType(GetAllVehcileType event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(vehicleType: const Result.loading()));
    final result = await _facade.getAllVehiclType();
    result.fold((left) => null, (right) {
      form.control(carType).value = getIt<AuthLocal>().getUser()!.vehicle.vehicleTypeId;
      emit(state.copyWith(vehicleType: Result.loaded(data: right)));
      printB(form.control(carType).value);
    });
  }
}
