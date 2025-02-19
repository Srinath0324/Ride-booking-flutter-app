import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_booking_app/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!mounted) return;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).login(_mobileController.text, _passwordController.text);
        if (!mounted) return;
        navigator.pushReplacementNamed('/home');
      } catch (e) {
        if (!mounted) return;
        messenger.showSnackBar(const SnackBar(content: Text('Login failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () async {
                      if (!mounted) return;
                      final messenger = ScaffoldMessenger.of(context);

                      if (_mobileController.text.isNotEmpty) {
                        try {
                          await Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).forgotPassword(_mobileController.text);
                          if (!mounted) return;
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('Password reset link sent'),
                            ),
                          );
                        } catch (e) {
                          if (!mounted) return;
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('Failed to send reset link'),
                            ),
                          );
                        }
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your mobile number'),
                          ),
                        );
                      }
                    },
                    child: const Text('Forgot Password?'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Or continue with'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (!mounted) return;
                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);

                          try {
                            await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).signInWithGoogle();
                            if (!mounted) return;
                            navigator.pushReplacementNamed('/home');
                          } catch (e) {
                            if (!mounted) return;
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text('Google sign-in failed'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.g_mobiledata),
                        label: const Text('Google'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (!mounted) return;
                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);

                          try {
                            await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).signInWithFacebook();
                            if (!mounted) return;
                            navigator.pushReplacementNamed('/home');
                          } catch (e) {
                            if (!mounted) return;
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text('Facebook sign-in failed'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.facebook),
                        label: const Text('Facebook'),
                      ),
                    ],
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
