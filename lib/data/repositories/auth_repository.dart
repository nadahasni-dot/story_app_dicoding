import 'dart:developer';

import 'package:story_app_dicoding/data/responses/default_response.dart';

import '../network/api_endpoints.dart';
import '../network/network_service.dart';
import '../responses/post_login_response.dart';

class AuthRepository {
  static Future<LoginResult> login(
      {required String email, required String password}) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      final result = postLoginResponseFromJson(response);

      return result.loginResult;
    } catch (e) {
      log(e.toString(), name: "AUTH REPOSITORY");
      rethrow;
    }
  }

  static Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      final result = defaultResponseFromJson(response);

      if (result.error) return false;

      return true;
    } catch (e) {
      log(e.toString(), name: "AUTH REPOSITORY");
      rethrow;
    }
  }
}
