import '../../domain/entities/entities.dart';

class RemoteAccountModel {
  RemoteAccountModel(this.accessToken);

  final String accessToken;

  factory RemoteAccountModel.fromJson(Map json) =>
      RemoteAccountModel(json['accessToken']);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
