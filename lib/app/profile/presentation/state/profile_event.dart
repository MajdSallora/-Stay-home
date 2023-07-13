part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetProfile extends ProfileEvent{}

class ModifyProfile extends ProfileEvent{}
