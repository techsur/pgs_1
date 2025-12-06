import 'dart:async';
import '../models/user_model.dart';

abstract class AuthService {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> loginWithPhone(String phone, String password);
  Future<UserModel> register(UserModel user, String password);
  Future<void> sendOtp(String phone);
  Future<bool> verifyOtp(String phone, String otp);
  Future<void> resetPassword(String email);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<void> updateProfile(UserModel user);
  Future<bool> isLoggedIn();
}