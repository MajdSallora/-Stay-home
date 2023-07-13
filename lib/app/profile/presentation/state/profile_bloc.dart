import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  static const String username = "username";
  static const String email = "email";
  static const String phoneNumber = "phoneNumber";
  static const String birthdate = "birthdate";

  static FormGroup form = FormGroup(
      {
        username : FormControl<String>(
          validators:[Validators.required],
        ),
        email : FormControl<String>(
          validators:[Validators.required,Validators.email],
        ),
        phoneNumber : FormControl<String>(
          validators:[Validators.required,Validators.number],
        ),
        birthdate : FormControl<DateTime>(
          validators:[Validators.required],
        ),
      }
  );

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async{
      if(event is ModifyProfile){
        await save(event, emit);
      }
    });


  }
  Future<void> save(ModifyProfile event,Emitter emit) async{
    if(form.valid){

    }else{
      form.markAllAsTouched();
    }
  }
}
