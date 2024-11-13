import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your email to reset your password',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            CustomTextField(hintText: 'Email', controller: emailController),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Reset Password',
              onPressed: () {
                showDialog(context: context, builder: (BuildContext ctx) {
                  return const AlertDialog(
                    title: Text("Some title"),
                    content: Text("Some text"),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
