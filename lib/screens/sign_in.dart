import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:dio/dio.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Dio dio = Dio();


  Future<void> _sendDataToRequestCatcher(Map<String, dynamic> data) async {
    final url = 'https://authtester.requestcatcher.com/sign-in';
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
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 100),
              SizedBox(height: 20),
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
              SizedBox(height: 12),
              CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 7) {
                    return 'Password must be at least 7 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Sign In',
                onPressed:  () async {
                  if (_formKey.currentState?.validate() ?? false) {

                    final data = {
                  'email': emailController.text.trim(),
                  'password': passwordController.text.trim(),
                  };
                  await _sendDataToRequestCatcher(data);

                    showDialog(context: context, builder: (BuildContext ctx) {
                      return const AlertDialog(
                        title:Text("Message"),
                        content: Text("Success"),
                      );
                    });                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset-password');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
                child: Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
