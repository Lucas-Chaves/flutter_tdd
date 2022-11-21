import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd/domain/helpers/helpers.dart';
import 'package:flutter_tdd/domain/usecases/usecases.dart';

import 'package:flutter_tdd/data/http/http.dart';
import 'package:flutter_tdd/data/usecases/usecases.dart';

import 'remote_authentication_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpClientSpy>()])
class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late MockHttpClientSpy httpClient;
  late String url;
  late AuthenticationParams params;

  setUp(() {
    httpClient = MockHttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
  });

  test('Should call HttpClient with correct URL', () async {
    final accessToken = faker.guid.guid();
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => {
        'accessToken': accessToken,
        'name': faker.person.name(),
      },
    );
    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'email': params.email,
        'password': params.secret,
      },
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    ).thenThrow(HttpError.badRequest);

    //Act
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    ).thenThrow(HttpError.notFound);

    //Act
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    ).thenThrow(HttpError.serverError);

    //Act
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw InvalidCredentialsError if HttpClient returns 401',
      () async {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    ).thenThrow(HttpError.unauthorized);

    //Act
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });
  test('Should return an Account if HttpClient returns 200', () async {
    final accessToken = faker.guid.guid();
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => {
        'accessToken': accessToken,
        'name': faker.person.name(),
      },
    );

    //Act
    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });
}
