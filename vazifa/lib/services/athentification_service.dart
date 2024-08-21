import 'package:dio/dio.dart';

class AuthentificationService {
  final dio = Dio();

  Future<String> register(String name, String phoneNumber, int roleId,
      String password, String passwordConfirmation) async {
    try {
      final response = await dio
          .post("http://millima.flutterwithakmaljon.uz/api/register", data: {
        'name': name,
        'phone': phoneNumber,
        'role_id': roleId,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      print(response.data['data']['token']);

      return response.data['data']['token'];
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login(String phoneNumber, String password) async {
    try {
      final response = await dio
          .post("http://millima.flutterwithakmaljon.uz/api/login", data: {
        'phone': phoneNumber,
        'password': password,
      });

      print(response);

      return "${response.data['success']}-${response.data['data']['token']}";
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> logout(String token) async {
    print('logout');
    print(token);
    try {
      final response = await dio.post(
        "http://millima.flutterwithakmaljon.uz/api/logout",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      print(response);

      if (response.data['success'] == true) {
        return "success";
      }
      return "Failed to Log Out";
    } catch (e) {
      rethrow;
    }
  }
}
