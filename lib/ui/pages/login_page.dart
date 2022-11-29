import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage('lib/ui/assets/logo.png'),
            ),
            Text('Login'.toUpperCase()),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                MaterialButton(
                  onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
