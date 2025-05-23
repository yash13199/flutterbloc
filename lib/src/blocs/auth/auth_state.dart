
abstract class AuthState {}

class GoogleSignInInital extends AuthState {}

class GoogleSignInLoding extends AuthState {}

class GoogleSignInLoded extends AuthState {
  final String username;

  GoogleSignInLoded(this.username);
}

class UnAuth extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

