import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/accounts.dart';
import '../controller/routes.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class Login extends StatefulWidget {
  static  String id = "login";

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passcontroller=TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
   bool? _validate() {
    return _form.currentState?.validate();
  }

@override
  initState()  {
    // TODO: implement initState
    super.initState();
     FirebaseAccounts().innitial(context);

   // print(FirebaseAccounts().innitial(context).toString());
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text("Login"),
      ),
      body: ProgressHUD(
        barrierColor: Colors.black54,
        child: Consumer<FirebaseAccounts>(
          builder: (context, value, Widget? child){
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400

                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _form,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            SizedBox(
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("GOLD CALCULATOR",style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber[800]
                                  ),),
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: ValidationBuilder().email().maxLength(40).build(),
                                controller: emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    hintText: "Enter Your Email Address",
                                    labelText: "Email Address",
                                    border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: ValidationBuilder().minLength(6).build(),
                                controller: passcontroller,
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: "Enter Your Password",
                                    labelText: "Password",
                                    border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, Routes.usersignup);
                                },
                                child: Text("New? Create Account",style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 20,
                                ),),
                              ),
                            ),

                            ElevatedButton(onPressed: () async{
                              _validate();
                              String emailText=emailcontroller.text.toString().trim();
                              String passwordtext=passcontroller.text.toString().trim();
                              value.login(emailText, passwordtext,context);
                              if(_validate()!)
                                {
                                  final progress = ProgressHUD.of(context);
                                  progress?.showWithText('Please Wait...');

                                  Future.delayed(const Duration(seconds: 30), () {
                                    progress?.dismiss();
                                  });
                                final status= await value.login(emailText, passwordtext,context);
                                if(status)
                                  {
                                    print(status);
                                    progress?.dismiss();

                                  }
                                else
                                  {
                                    progress?.dismiss();

                                    const snack=SnackBar(content: Text("Incorrect Password or Email"),);
                                  ScaffoldMessenger.of(context).showSnackBar(snack);
                                  }

                                }



                            },style: ElevatedButton.styleFrom(backgroundColor: Colors.black54), child: const Text("Login into your account"),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );


          }

        ),
      ),
    );
  }
}
