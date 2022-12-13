import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/pages.dart';

import '../../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({required this.presenter, super.key});

  final LoginPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  StreamBuilder<String>(
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          key: const Key('EmailFormField'),
                          onChanged: presenter.validateEmail,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: snapshot.data,
                            icon: const Icon(Icons.email),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                    child: TextFormField(
                      onChanged: presenter.validatePassword,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text(
                      'Entrar'.toUpperCase(),
                    ),
                  ),
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
      ),
    );
  }
}
