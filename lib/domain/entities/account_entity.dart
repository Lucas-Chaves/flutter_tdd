class AccountEntity {
  AccountEntity(this.token);

  final String token;

  factory AccountEntity.fromJson(Map json) =>
      AccountEntity(json['accessToken']);
}
