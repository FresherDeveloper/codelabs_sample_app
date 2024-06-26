import 'package:coinone_sample_app/domain/use_cases/sign_in_use_case.dart';
import 'package:coinone_sample_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:coinone_sample_app/presentation/views/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSignInFormVisible = true;
  bool _keepLoggedIn = false; //  variable for checkbox state
  @override
  void initState() {
    super.initState();
    _loadKeepLoggedIn();
  }

  Future<void> _loadKeepLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final keepLoggedIn = prefs.getBool('keepLoggedIn') ?? false;
    if (keepLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _saveKeepLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('keepLoggedIn', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 25, 41),
      body: BlocProvider(
        create: (context) => AuthBloc(context.read<SignInUseCase>()),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error!),
              ));
            }
            if (state.isSignInSuccess) {
              _saveKeepLoggedIn(_keepLoggedIn);
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state.isSignUpSuccess) {
              setState(() {
                _isSignInFormVisible = true;
                _emailController.clear();
                _passwordController.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Sign up successful! Please log in."),
              ));
              Navigator.pushReplacementNamed(context, '/login');
            }
            // if (state.user != null) {
            //   Navigator.pushReplacementNamed(context, '/home');
            // }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isSignInFormVisible ? 'Login' : 'Sign Up',
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    _isSignInFormVisible
                        ? _buildSignInForm()
                        : _buildSignUpForm(),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Keep me logged in',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: _keepLoggedIn,
                      onChanged: (bool? value) {
                        setState(() {
                          _keepLoggedIn = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      tileColor: Colors.transparent,
                    ),
                    const SizedBox(height: 20),
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (_isSignInFormVisible) {
                                if (_signInFormKey.currentState!.validate()) {
                                  _signInFormKey.currentState!.save();
                                  context.read<AuthBloc>().add(
                                        SignInRequested(
                                          _emailController.text,
                                          _passwordController.text,
                                        ),
                                      );
                                }
                              } else {
                                if (_signUpFormKey.currentState!.validate()) {
                                  _signUpFormKey.currentState!.save();
                                  context.read<AuthBloc>().add(
                                        SignUpRequested(
                                          _emailController.text,
                                          _passwordController.text,
                                        ),
                                      );
                                }
                              }
                            },
                            child: Text(
                                _isSignInFormVisible ? 'Sign In' : 'Sign Up'),
                          ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _emailController.clear();
                          _passwordController.clear();
                          _isSignInFormVisible = !_isSignInFormVisible;
                        });
                      },
                      child: Text(_isSignInFormVisible
                          ? 'Switch to Sign Up'
                          : 'Switch to Sign In'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            labelText: 'Email',
            validatorTxt: 'Please enter your email',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            obscureText: true,
            controller: _passwordController,
            labelText: 'Password',
            validatorTxt: 'Please enter your password',
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            labelText: 'Email',
            validatorTxt: 'Please enter your email',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            obscureText: true,
            controller: _passwordController,
            labelText: 'Password',
            validatorTxt: 'Please enter your password',
          ),
        ],
      ),
    );
  }
}
