import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/pages.dart';

import '../../components/components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({required this.presenter, super.key});

  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          loadingDialog(context);
          snackbarError(context);
          return FormBody(presenter: widget.presenter);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  StreamSubscription<String?> snackbarError(BuildContext context) {
    return widget.presenter.mainErrorStream.listen((error) {
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[900],
            content: Text(
              error,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });
  }

  StreamSubscription<bool?> loadingDialog(BuildContext context) {
    return widget.presenter.isLoadingStream.listen((isLoading) {
      if (isLoading != null && isLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      'Aguarde...',
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            );
          },
        );
      } else {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    });
  }
}

class FormBody extends StatelessWidget {
  const FormBody({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  final LoginPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LoginHeader(),
          const HeadLine1(text: 'Login'),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
                child: Column(
              children: [
                StreamBuilder<String?>(
                    stream: presenter.emailErrorStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        key: const Key('EmailFormField'),
                        onChanged: presenter.validateEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: snapshot.data?.isEmpty == true
                              ? null
                              : snapshot.data,
                          icon: const Icon(Icons.email),
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                  child: StreamBuilder<String?>(
                      stream: presenter.passwordErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          onChanged: presenter.validatePassword,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            errorText: snapshot.data?.isEmpty == true
                                ? null
                                : snapshot.data,
                            icon: const Icon(Icons.lock),
                          ),
                          obscureText: true,
                        );
                      }),
                ),
                StreamBuilder<bool?>(
                    stream: presenter.isFormValidStream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed:
                            snapshot.data == true ? presenter.auth : null,
                        child: Text(
                          'Entrar'.toUpperCase(),
                        ),
                      );
                    }),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  label: Text(
                    'criar conta'.toUpperCase(),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
