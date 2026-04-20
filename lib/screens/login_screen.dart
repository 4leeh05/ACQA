import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_input.dart';
import '../widgets/gradient_button.dart';
import '../widgets/info_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final success = AuthService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha email e senha.')),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, '/calendar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  const AuthHeader(
                    title: 'Bem-vindo ao Organizador De Tarefas',
                    subtitle: 'Organize seu dia com estilo e produtividade.',
                  ),
                  const SizedBox(height: 28),
                  InfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Entrar',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CustomInput(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 14),
                        CustomInput(
                          controller: passwordController,
                          label: 'Senha',
                          icon: Icons.lock_outline_rounded,
                          obscureText: true,
                        ),
                        const SizedBox(height: 22),
                        GradientButton(
                          text: 'Entrar',
                          icon: Icons.login_rounded,
                          onPressed: _login,
                        ),
                        const SizedBox(height: 14),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text('Não é cadastrado? Cadastre-se'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
