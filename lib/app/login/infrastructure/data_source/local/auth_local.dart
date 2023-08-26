import 'dart:convert';

import 'package:driver_project/common/constant/keys.dart';
import 'package:driver_project/common/core/user/entities/user.dart';
import 'package:driver_project/common/core/utils/storage_service.dart';

class AuthLocal {
  final StorageService local;

  AuthLocal({required this.local});

  ///***************** user Storage **************
  Future<void> setUser(User value) async {
    await local.setString(kUserInfo, jsonEncode(value.toMap()));
  }

  bool isAuthenticated() {
    final String? string = local.getString(kUserInfo);
    return string != null && string.isNotEmpty;
  }

  removeUser() async {
    await local.remove(kUserInfo);
  }

  User? getUser() {
    final String? string = local.getString(kUserInfo);
    if (string != null) {
      Map<String, dynamic> d = json.decode(string);
      User user = User.fromMap(d);
      return user;
    }
    return null;
  }
}
