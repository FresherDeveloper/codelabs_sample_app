part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isSignUpSuccess;
  final bool isSignInSuccess;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isSignUpSuccess = false,
    this.isSignInSuccess = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isSignUpSuccess,
    bool? isSignInSuccess,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSignUpSuccess: isSignUpSuccess ?? this.isSignUpSuccess,
      isSignInSuccess: isSignInSuccess ?? this.isSignInSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [user, isLoading, error, isSignUpSuccess, isSignInSuccess];
}
