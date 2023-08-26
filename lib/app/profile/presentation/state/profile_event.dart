// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {}

class ModifyProfile extends ProfileEvent {}

class GetAllVehcileType extends ProfileEvent {}

class ChangeImage extends ProfileEvent {
  final String image;
  ChangeImage({
    required this.image,
  });
}
