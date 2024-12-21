import 'package:authentication_buttons/authentication_buttons.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
import '../controller/accounts.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
class Initpage extends StatefulWidget {
  Initpage({super.key});

  @override
  State<Initpage> createState() => _InitpageState();
}

class _InitpageState extends State<Initpage> {
  String name = "";
  int age = 0;
  String hometown = "";
  double grams = 0;
  double volume = 0;
  double price = 0;
  double density = 0;
  double karat = 0;
  double pounds = 0;
  double perpounds = 0;
  double total = 0;
  final gremstext = TextEditingController();
  final volumetxt = TextEditingController();
  final pricettxt = TextEditingController();

  late List datalist;

  //final _salesform=GlobalKey<FormState>();
  final GlobalKey<FormState> _salesform = GlobalKey<FormState>();



  bool? _validate() {
    _salesform.currentState?.validate();
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return   ProgressHUD(
      indicatorColor: Colors.orange,
      child: Consumer<FirebaseAccounts>(

        builder: (BuildContext context, data2, Widget? child) {
          return  Scaffold(
            backgroundColor: Colors.grey[00],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.orange,
              centerTitle: true,
              title:  const Text("Gold Calculator",style: TextStyle(color: Colors.white),),
            ),
            body: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Card(
                    child: Form(
                      key: _salesform,
                      child: Column(
                        children: [

                          Card(
                            color: Colors.orange[100],
                            child: Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: Column(

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: gremstext,
                                      validator: ValidationBuilder()
                                          .minLength(1)
                                          .build(),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          grams = double.parse(value);
                                          datalist = data2.density(
                                              grams, volume, price);
                                          density = datalist[0];
                                          pounds = datalist[1];
                                          karat = datalist[2];
                                          perpounds = datalist[3];
                                          total = datalist[4];
                                        }
                                      },
                                      keyboardType:
                                      const TextInputType.numberWithOptions(decimal: true),

                                      decoration:  const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Grams",
                                          label: Text("Grams",style: TextStyle(fontSize: 20),),

                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: volumetxt,
                                      validator: ValidationBuilder().minLength(1).build(),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          volume = double.parse(value);
                                          datalist = data2.density(
                                              grams, volume, price);
                                          density = datalist[0];
                                          pounds = datalist[1];
                                          karat = datalist[2];
                                          perpounds = datalist[3];
                                          total = datalist[4];
                                        }
                                      },

                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text("Volume",style: TextStyle(fontSize: 20),),
                                        hintText: "Volume",
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: pricettxt,
                                      validator: ValidationBuilder().minLength(1).build(),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          price = double.parse(value);
                                          datalist = data2.density(
                                              grams, volume, price);
                                          density = datalist[0];
                                          pounds = datalist[1];
                                          karat = datalist[2];
                                          perpounds = datalist[3];
                                          total = datalist[4];
                                        }
                                      },
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      decoration: const InputDecoration(
                                          label: Text("Price",style: TextStyle(fontSize: 20),),
                                          hintText: "Price",
                                          border: OutlineInputBorder()
                                      ),


                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Card(
                            color: Colors.orange[100],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Pounds:',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                      Text('$pounds',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 1,color: Colors.grey,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Density',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                      Text('$density',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 1,color: Colors.grey,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Karat',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                      Text('$karat',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 1,color: Colors.grey,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Per Pound',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                      Text('$perpounds',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 1,color: Colors.grey,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                      Text('$total',
                                        style: TextStyle(
                                            color: Colors.grey[600], // Set the text color.
                                            fontSize: 14 // Set the text size.
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AuthenticationButton(
                              showLoader: data2.progress,
                              buttonSize: ButtonSize.large,
                              authenticationMethod: AuthenticationMethod.google,
                              onPressed: () async{
                              //  await data2.auth.signOut();
                               // print(data2.progress);
                                final prog=ProgressHUD.of(context);
                                prog!.showWithText("Please wait...");
                                data2.googlesignup(context);
                                 prog.dismiss();
                               // print("object...");
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
