import 'package:dio/dio.dart';

import '../DTO/login_request.dart';
import '../DTO/user_response.dart';
import 'api_client.dart';

class AuthApi {
  /// 로그인 요청: 성공 시 UserResponse, 실패/오류 시 null 반환
  static Future<UserResponse?> login(LoginRequest request) async {
    try {
      final response = await ApiClient.dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      // 상태 코드가 200 이고, body 에 user 정보가 온다고 가정
      return UserResponse.fromJson(response.data);
    } on DioException catch (e) {
      // 서버에서 4xx/5xx 가 와도 DioException 으로 들어옴
      print('로그인 실패(DioException): ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      print('로그인 실패(기타 에러): $e');
      return null;
    }
  }
}

