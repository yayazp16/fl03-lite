import 'package:fl03_lite/provider/auth_provider.dart';
import 'package:fl03_lite/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({Key? key, required this.userName}) : super(key: key);
  final String userName;
  @override
  Widget build(BuildContext context, ref) {
    //  Get username from authProvider for display in screen.
    var auth = ref.read(authProvider);
    return WillPopScope(
      onWillPop: () async {
        //  Show modal bottom sheet to confirm the user action when pressed back.
        showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return SignOutBottomSheet(
                authService: auth,
              );
            });
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.blue[600],
          appBar: AppBar(
            backgroundColor: Colors.blue[600],
            elevation: 0,
            centerTitle: true,
            title: const Text("Firebase Login sukon_sahunalu"),
          ),
          body: SafeArea(
            child: Center(
                child: Text(
              "Welcome, $userName",
              style: const TextStyle(color: Colors.white, fontSize: 30),
            )),
          )),
    );
  }
}

class SignOutBottomSheet extends StatelessWidget {
  const SignOutBottomSheet({
    Key? key,
    required this.authService,
  }) : super(key: key);
  final FireBaseAuthService authService;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          height: 120,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text("Are you sure to sign out?",
                    style: TextStyle(fontSize: 17)),
              ),
              TextButton(
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red[400], fontSize: 20),
                ),
                onPressed: () async {
                  //  Sign out and pop this modal sheet.
                  await authService.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          )),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          height: 70,
          child: Center(
              child: TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )),
        ),
      ],
    );
  }
}
