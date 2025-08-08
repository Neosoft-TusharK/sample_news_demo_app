import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/register_usecase_provider.dart';
import 'package:news_demo_app/di/secure_storage_service_provider.dart';
import 'package:news_demo_app/features/news/presentation/screens/news_home_screen.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text('Register', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await ref
                        .read(registerUseCaseProvider)
                        .call(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                        );
                    ref.read(authUserProvider.notifier).state = user;
                    // TODO: This should call our backend securely to get the API key after login
                    final keyFromServer =
                        'pub_1a6250e0999f4cd58b9eeaeb0940ad85'; // Example key
                    await ref
                        .watch(secureStorageServiceProvider)
                        .saveApiKey(keyFromServer);
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NewsHomeScreen(),
                        ),
                        (_) => false,
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration failed: $e')),
                      );
                    }
                  }
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
