import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100,),
            const SizedBox(height: 20),
            CustomTextField(hintText: 'Email', controller: emailController),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Sign In',
              onPressed: () {
                showDialog(context: context, builder:
                (BuildContext ctx) {
                  return const AlertDialog(
                    title: Text("Some message"),
                    content: Text("Some text here"),
                  );
                });
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reset-password');
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.green
              ),
              child: const Text('Forgot Password?')
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.green
              ),
              child:  const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
