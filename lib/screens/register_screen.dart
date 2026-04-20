import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_input.dart';
import '../widgets/gradient_button.dart';
import '../widgets/info_card.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final raController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    raController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _register() {
    final success = AuthService.register(
      name: nameController.text,
      ra: raController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro realizado com sucesso!')),
    );

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
                    title: 'Crie sua conta',
                    subtitle: 'Cadastre-se para acompanhar suas tarefas diárias.',
                  ),
                  const SizedBox(height: 28),
                  InfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Cadastro',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CustomInput(
                          controller: nameController,
                          label: 'Nome',
                          icon: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 14),
                        CustomInput(
                          controller: raController,
                          label: 'RA',
                          icon: Icons.badge_outlined,
                        ),
                        const SizedBox(height: 14),
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
                          text: 'Cadastrar',
                          icon: Icons.app_registration_rounded,
                          onPressed: _register,
                        ),
                        const SizedBox(height: 14),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Voltar para login'),
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
