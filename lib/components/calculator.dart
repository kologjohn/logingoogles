import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
import '../controller/accounts.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
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
    return Consumer<FirebaseAccounts>(
      builder: (BuildContext context, data2, Widget? child) {
        return ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Form(
                  key: _salesform,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white12,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: gremstext,
                                  validator:
                                      ValidationBuilder().minLength(1).build(),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      grams = double.parse(value);
                                      datalist =
                                          data2.density(grams, volume, price);
                                      density = datalist[0];
                                      pounds = datalist[1];
                                      karat = datalist[2];
                                      perpounds = datalist[3];
                                      total = datalist[4];
                                    }
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: const InputDecoration(
                                      hintText: "Grams",
                                      labelStyle: TextStyle(
                                          color: Colors.white54, fontSize: 16),
                                      hintStyle: TextStyle(
                                          color: Colors.white54, fontSize: 16),
                                      label: Text(
                                        "Grams",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      fillColor: Colors.black54,
                                      filled: true),
                                ),
                              ),
                              const SizedBox(
                                  width: 10,
                                  child: ColoredBox(color: Colors.white)),
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: volumetxt,
                                  validator:
                                      ValidationBuilder().minLength(1).build(),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      volume = double.parse(value);
                                      datalist =
                                          data2.density(grams, volume, price);
                                      density = datalist[0];
                                      pounds = datalist[1];
                                      karat = datalist[2];
                                      perpounds = datalist[3];
                                      total = datalist[4];
                                    }
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black54,
                                    label: Text(
                                      "Volume",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    hintText: "Volume",
                                    labelStyle: TextStyle(
                                        color: Colors.white54, fontSize: 16),
                                    hintStyle: TextStyle(
                                        color: Colors.white54, fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: pricettxt,
                                  validator:
                                      ValidationBuilder().minLength(1).build(),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      price = double.parse(value);
                                      datalist =
                                          data2.density(grams, volume, price);
                                      density = datalist[0];
                                      pounds = datalist[1];
                                      karat = datalist[2];
                                      perpounds = datalist[3];
                                      total = datalist[4];
                                    }
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      filled: true,
                                      label: Text(
                                        "Price",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      hintText: "Price",
                                      labelStyle: TextStyle(
                                          color: Colors.white54, fontSize: 16),
                                      hintStyle: TextStyle(
                                          color: Colors.white54, fontSize: 16),
                                      fillColor: Colors.black45),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(
                          height: 10,
                          thickness: 2,
                          color: Colors.black12,
                        ),
                      ),
                      Card(
                        color: Colors.white12,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pounds:',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                  Text(
                                    '$pounds',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Density',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                  Text(
                                    '$density',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Karat',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                  Text(
                                    '$karat',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Per Pound',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                  Text(
                                    '$perpounds',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
                                        fontSize: 14 // Set the text size.
                                        ),
                                  ),
                                  Text(
                                    '$total',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        // Set the text color.
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _validate();
                                    if (grams > 0 && volume > 0 && price > 0) {
                                      final progres = ProgressHUD.of(context);
                                      progres!.showWithText("Saving Record");
                                      Future.delayed(
                                          const Duration(seconds: 10), () {
                                        progres.dismiss();
                                      });
                                      String? email =
                                          data2.auth.currentUser!.email;
                                      // data2.db.enablePersistence();
                                      data2.addNewrecord(
                                          grams,
                                          volume,
                                          price,
                                          density,
                                          pounds,
                                          karat,
                                          perpounds,
                                          total,
                                          email!);

                                      progres.dismiss();
                                      gremstext.clear();
                                      volumetxt.clear();
                                      pricettxt.clear();
                                      grams = 0;
                                      volume = 0;
                                      price = 0;
                                      const snack = SnackBar(
                                          content: Text(
                                              "Record Saved Successfully"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack);
                                      data2.getTransactions();
                                      //    _salesform.currentState!.reset();

                                      // print("Status: ${insert}");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white12),
                                  child: const Text(
                                    "Save Record",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
