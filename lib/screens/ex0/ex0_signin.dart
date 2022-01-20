import 'package:fl03_lite/provider/auth_provider.dart';
import 'package:fl03_lite/screens/ex0/ex0_signup.dart';
import 'package:fl03_lite/widget/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
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
                          FocusScope.of(context).unfocus(); // Dismiss keyboard
                          // Validate email and password from InputTextField.
                          if (formKey.currentState!.validate()) {
                            String error = await ref.read(authProvider).signIn(
                                emailTextController.text,
                                passwordTextController.text);
                            // Check error: If firebase return an error message, show the message.
                            if (error.isNotEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(error),
                                action: SnackBarAction(
                                    label: "OK", onPressed: () {}),
                              ));
                            }
                          }
                        },
                        child: const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "LOG IN",
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
            if (MediaQuery.of(context).viewInsets.bottom == 0)  //  Go to SignUp page: Remove when this part is overlaid by the keyboard layer to prevent layout overflow.
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            )),
                        child: const Text("Sign Up",
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
