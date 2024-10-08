// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:vazifa/data/model/authentification_response.dart';
import 'package:vazifa/data/model/social_login_request.dart';
import 'package:vazifa/data/services/authentification_interseptor.dart';

class AuthentificationService {
  final Dio dio;

  AuthentificationService() : dio = Dio() {
    dio.interceptors.add(AuthInterceptor());
  }

  Future register(String name, String phoneNumber, int roleId, String password,
      String passwordConfirmation) async {
    try {
      final response = await dio
          .post("http://millima.flutterwithakmaljon.uz/api/register", data: {
        'name': name,
        'phone': phoneNumber,
        'role_id': roleId,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future login(String phoneNumber, String password) async {
    try {
      final response = await dio
          .post("http://millima.flutterwithakmaljon.uz/api/login", data: {
        'phone': phoneNumber,
        'password': password,
      });

      return response.data;
    } on DioException catch (error) {
      return error.response!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthenticationResponse> socialLogin(SocialLoginRequest request) async {
    try {
      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/social-login',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> logout() async {
    try {
      final response = await dio.post(
        "http://millima.flutterwithakmaljon.uz/api/logout",
      );

      if (response.data['success'] == true) {
        return "success";
      }
      return "Failed to Log Out";
    } catch (e) {
      rethrow;
    }
  }
}
