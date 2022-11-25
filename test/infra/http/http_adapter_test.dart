import 'package:faker/faker.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart';
import 'package:flutter_tdd/infra/http/http.dart';
import 'http_adapter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ClientSpy>()])
class ClientSpy extends Mock implements Client {}

void main() {
  late MockClientSpy client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = MockClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    PostExpectation mockRequest() => when(
        client.post(any, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(int statusCode,
            {String body = '{"any_key":"any_value"}'}) =>
        mockRequest()..thenAnswer((_) async => Response(body, statusCode));

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
      );

      verify(
        client.post(
          Uri(path: url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
          },
          body: '{"any_key":"any_value"}',
        ),
      );
    });

    test('Should call post without body', () async {
      await sut.request(
        url: url,
        method: 'post',
      );

      verify(
        client.post(
          any,
          headers: anyNamed('headers'),
        ),
      );
    });
    test('Should return data if post returns 200 with null data', () async {
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {"any_key": "any_value"});
    });
    test('Should return data if post returns 200', () async {
      mockResponse(200, body: '');

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {});
    });
    test('Should return data if post returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {});
    });
    test('Should return data if post returns 204', () async {
      mockResponse(204);

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {});
    });
  });
}
