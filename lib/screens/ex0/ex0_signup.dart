import 'package:fl03_lite/provider/auth_provider.dart';
import 'package:fl03_lite/widget/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late TextEditingController userTextController;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    userTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    userTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Image.asset(
                          "assets/Firebase_Logo_Logomark.png",
                          width: 100,
                          height: 150,
                        ),
                      ),
                      InputTextField(
                        controller: emailTextController,
                        hintText: "Email",
                        icon: Icons.email_outlined,
                        emailValidation: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        controller: userTextController,
                        hintText: "Username",
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        controller: passwordTextController,
                        obscure: true,
                        hintText: "Password",
                        icon: Icons.lock_outline,
                        passwordValidation: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            String error = await ref.read(authProvider).signUp(
                                emailTextController.text,
                                passwordTextController.text,
                                userTextController.text);
                            //ref.refresh(authState);

                            if (error.isNotEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(error),
                                action: SnackBarAction(
                                    label: "OK", onPressed: () {}),
                              ));
                            } else {
                              Navigator.of(context).pop();
                              /*Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) =>  WelcomePage(),
                              ));*/
                            }
                          }
                        },
                        child: const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                              ),
                            )),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Sign In",
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
          ],
        ),
      )),
    );
  }
}
