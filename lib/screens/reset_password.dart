import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:dio/dio.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  final Dio dio = Dio();


  Future<void> _sendDataToRequestCatcher(Map<String, dynamic> data) async {
    final url = 'https://authtester.requestcatcher.com/reset-password';
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print('Response: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Request Data: ${e.requestOptions.data}');
        print('Response Data: ${e.response?.data}');
      } else {
        print('Other Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your email to reset your password',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 12),
              CustomTextField(
                hintText: 'Email',
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Send Reset Link',
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final data = {
                      'email': emailController.text.trim(),
                    };
                    await _sendDataToRequestCatcher(data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
