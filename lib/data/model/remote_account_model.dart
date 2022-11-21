import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteAccountModel {
  RemoteAccountModel(this.accessToken);

  final String accessToken;

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
