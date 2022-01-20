import 'package:flutter/material.dart';

class ErrorLoadingPage extends StatelessWidget {
  const ErrorLoadingPage({Key? key, this.errorText = false}) : super(key: key);
  final bool errorText;


  //  errorText = true: show error message
  //  errorText = false: show CircularProgressIndicator
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[600],
        body: SafeArea(
          child: !errorText
              ? const Center(child: CircularProgressIndicator())
              : const Center(
                  child: Text(
                      "Error occurred while logging in. Please try again.")),
        ));
  }
}
