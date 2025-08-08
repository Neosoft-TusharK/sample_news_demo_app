import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/core/services/secure_storage_service.dart';
import 'package:news_demo_app/di/login_usecase_provider.dart';
import 'package:news_demo_app/di/secure_storage_service_provider.dart';
import 'package:news_demo_app/features/auth/presentation/screens/register_screen.dart';
import 'package:news_demo_app/features/news/presentation/screens/news_home_screen.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login', style: TextStyle(fontSize: 24)),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = await ref
                      .read(loginUsecaseProvider)
                      .call(emailController.text, passwordController.text);
                  ref.read(authUserProvider.notifier).state = user;
                  // After user login success
                  // TODO: This should call our backend securely to get the API key after login
                  final keyFromServer =
                      'pub_1a6250e0999f4cd58b9eeaeb0940ad85'; // Example key
                  await ref
                      .watch(secureStorageServiceProvider)
                      .saveApiKey(keyFromServer);

                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const NewsHomeScreen()),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    // Show error message
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
                  }
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );
              },
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
