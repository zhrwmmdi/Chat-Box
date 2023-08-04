import 'package:chat_box/Components/Rounded_Button.dart';
import 'package:chat_box/Screens/chat_screen.dart';
import 'package:chat_box/services/authService.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool errorOccurred = false;
  bool showSpinner = false;
  String errorMessage = '';

  void _registerAction() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(
          () {
            showSpinner = true;
            errorOccurred = false;
          },
        );
        await AuthService()
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then(
          (value) {
            Navigator.pop(context);
            Navigator.pushNamed(context, ChatScreen.id);
          },
        );
        setState(
          () {
            showSpinner = false;
          },
        );
      } catch (e) {
        setState(() {
          showSpinner = false;
          errorOccurred = true;
          errorMessage = e.toString().split('] ')[1];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your Email', labelText: 'Email'),
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) {
                        return email != null && EmailValidator.validate(email)
                            ? null
                            : 'Please enter a valid Email';
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      onFieldSubmitted: (event) {
                        _registerAction();
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password',
                          labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (password) {
                        return password != null && password.length > 5
                            ? null
                            : 'The password should be at least 6 characters';
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Visibility(
                visible: errorOccurred,
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
              RoundedButton(
                title: 'Register',
                onPressed: () {
                  _registerAction();
                },
                color: kRegisterButtonColor,
              ),
              const SizedBox(height: 12),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
