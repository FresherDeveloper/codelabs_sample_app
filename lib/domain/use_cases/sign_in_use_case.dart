import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:coinone_sample_app/domain/entities/user.dart';
import 'package:coinone_sample_app/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<User> signIn(String email, String password) {
    return authRepository.signIn(email, password);
  }

  Future<User> signUp(String email, String password) {
    return authRepository.signUp(email, password);
  }

  Future<void> signOut() {
    return authRepository.signOut();
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://coinoneglobal.in/teresa_trial/webtemplate.asmx/FnGetTemplateCategoryList?PrmCmpId=1&PrmBrId=2'),
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      log(response.statusCode.toString());
      return jsonData as List<dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }

   Future<List<dynamic>> fetchImageDetails(String categoryId) async {
    final response = await http.get(
      Uri.parse(
          'https://coinoneglobal.in/teresa_trial/webtemplate.asmx/FnGetTemplateSubCategoryList?PrmCmpId=1&PrmBrId=2&PrmCategoryId=$categoryId'),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return jsonData as List<dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
