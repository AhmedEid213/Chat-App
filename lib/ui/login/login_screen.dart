import 'dart:async';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_navigator.dart';
import 'package:chat_app/ui/login/login_view_model.dart';
import 'package:chat_app/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils.dart' as Utils;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'logIn';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  bool _obscureText = true;
  String email = '';
  String password = '';
  var formKey = GlobalKey<FormState>();
  LoginViewModel viewModel = LoginViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Login'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'email',
                      ),
                      onChanged: (text) {
                        email = text;
                      },
                      validator: (text) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text!);
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email';
                        }
                        if (!emailValid) {
                          return 'please enter valid email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.key),
                        labelText: 'password',
                        suffixIcon: GestureDetector(
                          onTap: (){
                            _obscureText = !_obscureText;
                            setState(() {

                            });
                          },
                          child: Icon(_obscureText?
                              Icons.visibility_off:
                              Icons.visibility
                          ),
                        )
                      ),
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your password';
                        }
                        if (text.length < 6) {
                          return 'password must be at least 6 chars.';
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: Text('Login')),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    }, child: Text('Create Account'))
                  ],
                ),
              )),
        )
      ]),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      //login
      viewModel.loginFireBaseAuth(email, password);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'ok', (context) {
      Navigator.pop(context);
    });
  }
  @override
  void navigateToHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user =user;
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    });
  }
}
