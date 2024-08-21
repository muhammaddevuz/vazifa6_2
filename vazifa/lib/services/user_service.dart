import 'package:dio/dio.dart';

class UserService {
  final dio = Dio();

  Future<Map<String, dynamic>> getUser(String token) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/user',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      print(response);

      if (response.data['success'] == false) {
        throw response.data;
      }

      return response.data;
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
