import 'package:flutter/material.dart';
import 'package:lobbying/const/styles/fonts.dart';
import 'package:lobbying/data/commons/nav_utils.dart';
import 'package:lobbying/data/model/login_model.dart';
import 'package:lobbying/data/provider/authentication_provider.dart';
import 'package:lobbying/ui/pages/main/home_page_screen.dart';
import 'package:lobbying/ui/widgets/buttons/button_primary.dart';
import 'package:lobbying/ui/widgets/textfields/password_field_custom.dart';
import 'package:lobbying/ui/widgets/textfields/text_field_custom.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _error = false;
  bool _isLoading = false;
  String _errorMessage = "No Response";

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://miro.medium.com/v2/resize:fit:1200/1*TK4sF5ewYTHLzEkib7Ndrw.jpeg"),
                    ),
                  ),
                ),
                Text(
                  "Login",
                  style: TextStyleL.primaryTextStyle.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFieldCustom(
                  title: "Email",
                  hintText: "Masukan Email",
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                PasswordFieldCustom(
                  title: "Password",
                  hintText: "Masukan Password Disini",
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                _error == true
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _errorMessage,
                          style: TextStyleL.primaryTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                ButtonPrimary(
                  title: "Login",
                  onTap: () {
                    _isLoading = true;
                    _error = false;
                    setState(() {
                      Future.delayed(const Duration(seconds: 2), () {
                        auth
                            .login(
                                emailController.text, passwordController.text)
                            .then((value) {
                          // ignore: unrelated_type_equality_checks

                          if (value.data["success"] == true) {
                            // ignore: unused_local_variable
                            final loginModel = LoginModel.fromJson(value.data);
                            auth.setToken(
                                loginModel.data.token, loginModel.data.name);
                            nextScreenRemoveUntil(const HomePageScreen());
                          } else {
                            _error = true;
                            _errorMessage =
                                "Silahkan Periksa Kembali email / password!!";
                          }
                          _isLoading = false;
                          setState(() {});
                        });
                      });
                      // _isLoading = false;
                    });
                  },
                  isLoading: _isLoading,
                  enabled: !_isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
