import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

import '../controller/accounts.dart';

// ignore: must_be_immutable
class Signup extends StatelessWidget {
  Signup({super.key});
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController nametxt = TextEditingController();
  TextEditingController phonetxt = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _validate() {
    return _form.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "New Account",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ProgressHUD(
        barrierEnabled: false,
        barrierColor: Colors.black26,
        backgroundColor: Colors.black54,
        child: Consumer<FirebaseAccounts>(
          builder: (context, value, Widget? child) {
            if (value.auth.currentUser != null) {
              String? name = value.auth.currentUser?.displayName!;
              String? email = value.auth.currentUser?.email!;
              nametxt.text = name!;
              emailTxt.text = email!;
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ListView(
                    children: [
                      Form(
                        key: _form,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator:
                                    ValidationBuilder().minLength(1).build(),
                                keyboardType: TextInputType.name,
                                controller: nametxt,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Enter Full Name",
                                    labelText: "Full Name"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                validator: ValidationBuilder()
                                    .email()
                                    .minLength(5)
                                    .build(),
                                controller: emailTxt,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Enter Email Address",
                                    labelText: "Email"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: ValidationBuilder()
                                    .maxLength(10)
                                    .minLength(10)
                                    .build(),
                                keyboardType: TextInputType.number,
                                controller: phonetxt,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Enter Phone Number ",
                                    labelText: "Phone Number "),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator:
                                      ValidationBuilder().minLength(6).build(),
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  controller: passwordTxt,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Password",
                                      labelText: "Password"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.orange),
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                onPressed: () async {
                                  String nameinput = nametxt.text.toString();
                                  String emailinput = emailTxt.text.toString();
                                  String passswordinput = "";
                                  String phoneinput = phonetxt.text.toString();
                                  _validate();
                                  if (_validate()) {
                                    final progress = ProgressHUD.of(context);
                                    progress
                                        ?.showWithText("Creating Account...");
                                    // Future.delayed(const Duration(seconds: 3), () => {progress?.dismiss()});
                                    String g = await value.signup(
                                        context,
                                        emailinput,
                                        passswordinput,
                                        nameinput,
                                        phoneinput);
                                    progress!.dismiss();
                                    final snack = SnackBar(
                                      content: Text(g),
                                      shape: const Border(),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snack);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
