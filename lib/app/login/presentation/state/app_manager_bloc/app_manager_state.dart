part of 'app_manager_bloc.dart';

class AppManagerState extends Equatable {
  const AppManagerState({required this.status, this.message, this.expired = false, this.checkedUpdate = false, this.choosePassed = false, this.isGuest = false, this.isSupported = false
      // this.expiredToken = false
      });

  final Status status;
  final String? message;
  final bool expired;
  final bool checkedUpdate;
  final bool choosePassed;
  final bool isSupported;
  final bool isGuest;
  // final bool expiredToken;

  @override
  List<Object?> get props => [status, message, expired, checkedUpdate, choosePassed, isGuest, isSupported];

  copyWith({Status? status, String? message, bool? checkedUpdate, bool? expired, bool? isGuest, bool? choosePassed, bool? isSupported}) {
    return AppManagerState(
      expired: expired ?? this.expired,
      isGuest: isGuest ?? this.isGuest,
      choosePassed: choosePassed ?? this.choosePassed,
      checkedUpdate: checkedUpdate ?? this.checkedUpdate,
      status: status ?? this.status,
      message: message ?? this.message,
      isSupported: isSupported ?? this.isSupported,
    );
  }

  @override
  String toString() {
    return status.name + "+ $choosePassed   ${message ?? ""}";
  }
}
