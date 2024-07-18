import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:news_app/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isNewUser = false;
  bool _view = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _viewPassword() {
    setState(() {
      _view = !_view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                'MyNews',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                isNewUser
                    ? TextField(
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary,
                          hintText: 'Name',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: 'Email',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                  controller: passwordController,
                  obscureText: _view ? false : true,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: _viewPassword,
                      child: Icon(
                        _view ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        const CircularProgressIndicator();
                      });
                      String name = isNewUser ? nameController.text.trim() : "";
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();
                      User? user = isNewUser
                          // ignore: use_build_context_synchronously
                          ? await context
                              .read<AuthService>()
                              .signUpWithEmail(email, password, name)
                          // ignore: use_build_context_synchronously
                          : await context
                              .read<AuthService>()
                              .signInWithEmail(email, password);
                      if (user != null) {
                        if (isNewUser) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'User added successfully! Please try logging in.'),
                            ),
                          );
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('emailId or password is incorrect'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      isNewUser ? 'Signup' : 'Login',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isNewUser = !isNewUser;
                      });
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 12, wordSpacing: 0.4),
                        children: [
                          TextSpan(
                            text: isNewUser ? 'Login' : 'Signup',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
