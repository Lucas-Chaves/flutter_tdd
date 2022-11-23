import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_adapter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ClientSpy>()])
class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    await client.post(Uri(path: url), headers: headers);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = MockClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      await sut.request(url: url, method: 'post');

      verify(
        client.post(
          Uri(path: url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
          },
        ),
      );
    });
  });
}
