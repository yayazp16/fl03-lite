import 'package:fl03_lite/provider/auth_provider.dart';
import 'package:fl03_lite/screens/ex0/ex0_error.dart';
import 'package:fl03_lite/screens/ex0/ex0_signin.dart';
import 'package:fl03_lite/screens/ex0/ex0_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //  Automatically navigates to each page based on user state changes.
    //  SignInPage: If the user hasn't signed in.
    //  WelcomePage: The user has already signed in.
    //  ErrorLoadingPage: When an error occurred or wait for firebase connect to server.
    var user = ref.watch(authState);
    return user.when(
        data: (user) {
          if (user != null) {
            return  WelcomePage(userName: user.displayName?? "Loading..",);
          } else {
            return const SignInPage();
          }
        },
        error: (_, __) => const ErrorLoadingPage(
              errorText: true,
            ),
        loading: () => const ErrorLoadingPage());
  }
}
