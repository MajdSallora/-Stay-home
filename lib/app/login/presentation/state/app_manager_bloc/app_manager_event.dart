part of 'app_manager_bloc.dart';

abstract class AppManagerEvent {
  const AppManagerEvent();
}

class AppManagerStarted extends AppManagerEvent {}

class AppManageStatusChanged extends AppManagerEvent {
  final String? message;
  final Status status;

  const AppManageStatusChanged({
    this.message,
    required this.status,
  });
}

class AppManagerLoggedOut extends AppManagerEvent {
  final String? message;

  const AppManagerLoggedOut({
    this.message,
  });
}

class AppMangerExpiredApp extends AppManagerEvent {
  final bool isSupported;

  AppMangerExpiredApp({required this.isSupported});
}

class AppMangerUnExpiredApp extends AppManagerEvent {}

class GetCities extends AppManagerEvent{}