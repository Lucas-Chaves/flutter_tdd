import '../entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth({
    required AuthenticationParams params,
  });
}

class AuthenticationParams {
  AuthenticationParams({
    required this.email,
    required this.secret,
  });
  final String email;
  final String secret;
}
