// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_tdd/test/data/usecases/remote_authentication_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;

import 'remote_authentication_test.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [HttpClientSpy].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClientSpy extends _i1.Mock implements _i2.HttpClientSpy {
  @override
  _i3.Future<Map<dynamic, dynamic>> request({
    required String? url,
    required String? method,
    Map<dynamic, dynamic>? body,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #request,
          [],
          {
            #url: url,
            #method: method,
            #body: body,
          },
        ),
        returnValue:
            _i3.Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}),
        returnValueForMissingStub:
            _i3.Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}),
      ) as _i3.Future<Map<dynamic, dynamic>>);
}
