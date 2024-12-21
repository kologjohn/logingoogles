import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../controller/accounts.dart';
class Menus{

  static PopupMenuItem buildPopupMenuItem(String title, IconData iconData,BuildContext context) {
    return PopupMenuItem(
      child:  GestureDetector(
        onTap: (){
          if(title=="Logout")
            {
              FirebaseAccounts().logout(context);
            }
        },
        child: Row(
          children: [
            Icon(iconData, color: Colors.black,),
            Text(title),
          ],
        ),
      ),
    );
  }

  //modal box for diplay of infoinformation
  void calculator(context, density, pounds, karat, perpound, total,String key, grams, volume,  price) {
    GlobalKey<FormState> _form=GlobalKey<FormState>();
    late List datalist;
    bool? validate(){
     return _form.currentState?.validate();
    }

    // Show a modal bottom sheet with the specified context and builder method.


    showMaterialModalBottomSheet(backgroundColor:Colors.black,bounce:false,context: context, builder: (BuildContext bc) {

      return SingleChildScrollView(
        child: Consumer<FirebaseAccounts>(
          builder: (context, data, child) {
            return Container(
              height: 700,
              decoration: const BoxDecoration(
                border: Border.symmetric(),
                borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                color: Colors.white,

              ),
              // Define padding for the container.
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              // Create a Wrap widget to display the sheet contents.
              child: Wrap(
                children:[
                  // Add a container with height to create some space.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex:4,child: Text("Edit Record ", style: TextStyle(color:Colors.blue,fontSize: 18, fontWeight: FontWeight.w500),)),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          style: TextButton.styleFrom(foregroundColor: Colors.transparent,), // Make the button text transparent.
                          onPressed: (){
                            Navigator.pop(context); // Close the sheet.
                          }
                          , icon: const Icon(Icons.close,color: Colors.orange,size: 20,),),
                      ),
                    ],

                  ),
                  const Divider(thickness: 5,color: Colors.black12,),
                  // Add a text widget with a title for the sheet.
                  Container(height: 10), // Add some more space.

                  // Add a text widget with a long description for the sheet.
                  Form(
                      key: _form,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              validator: ValidationBuilder().minLength(1).build(),
                              onChanged: (value){
                                if(value.isNotEmpty && value!=0 && volume!=0)
                                {
                                  grams = double.parse(value);
                                  double volume_double=double.parse("$volume");
                                  double price_double=double.parse("$price");
                                  datalist = data.density(grams, volume_double, price_double);
                                  density = datalist[0];
                                  pounds = datalist[1];
                                  karat = datalist[2];
                                  perpound = datalist[3];
                                  total = datalist[4];
                                }
                              },
                              initialValue: "$grams",
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(
                                  label: Text("Grams"),
                                  hintText: "Grams",
                                  filled: true
                              ),
                            ),
                          ),
                          const SizedBox(width: 6,),

                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              validator: ValidationBuilder().minLength(1).build(),
                              onChanged: (value){
                                if(value.isNotEmpty && value!=0 ) {
                                  volume = double.parse(value);
                                 double price_double=double.parse("$price");
                                  datalist = data.density(grams, volume, price_double);
                                  density = datalist[0];
                                  pounds = datalist[1];
                                  karat = datalist[2];
                                  perpound = datalist[3];
                                  total = datalist[4];
                                }

                              },
                              initialValue: "$volume",
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(
                                hintText: "Volume",
                                label: Text("Volume"),
                                filled: true,

                              ),
                            ),
                          ),
                          const SizedBox(width: 6,),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              validator: ValidationBuilder().minLength(1).build(),
                              onChanged: (value){
                                if(value.isNotEmpty && value!=0) {
                                  price = double.parse(value);
                                  datalist = data.density(grams, volume, price);
                                  density = datalist[0];
                                  pounds = datalist[1];
                                  karat = datalist[2];
                                  perpound = datalist[3];
                                  total = datalist[4];
                                }

                              },
                              initialValue: "$price",
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(
                                  hintText: "Price",
                                  filled: true,
                                  labelText: "Price"
                              ),
                            ),
                          )
                        ],

                      )),
                  SizedBox(height: 100,),
                  Column(
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
                      const Divider(thickness: 1,color: Colors.black38,),
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
                      const Divider(thickness: 1,color: Colors.black38,),

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
                      const Divider(thickness: 1,color: Colors.black38,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Per Pound',
                            style: TextStyle(
                                color: Colors.grey[600], // Set the text color.
                                fontSize: 14 // Set the text size.
                            ),
                          ),
                          Text('$perpound',
                            style: TextStyle(
                                color: Colors.grey[600], // Set the text color.
                                fontSize: 14 // Set the text size.
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1,color: Colors.black38,),
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


                  Container(height: 10), // Add some more space.
                  // Add a row widget to display buttons for closing and reading more.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align the buttons to the right.
                    children: <Widget>[
                      // Add a text button to close the sheet.
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,), // Set the button background color.
                        onPressed: (){
                          validate();
                          if(validate()!){
                            String? email=data.auth.currentUser!.email;
                            double grams_double=double.parse("$grams");
                            double volume_double=double.parse("$volume");
                            double price_double=double.parse("$price");
                            double density_double=double.parse("$density");
                            double pounds_double=double.parse("$pounds");
                            double karat_double=double.parse("$karat");
                            double perpound_double=double.parse("$perpound");
                            double total_double=double.parse("$total");
                            data?.updateRecord(grams_double, volume_double, price_double, density_double, pounds_double, karat_double, perpound_double, total_double, email!,key);
                            const snack=SnackBar(content: Text("Record Updated Successfully"));
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                            Navigator.pop(context);

                          }



                        }, // Add the button onPressed function.
                        child:  Text("Update Record", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)), // Add the button text.
                      ),

                      // Add an elevated button to read more.

                    ],
                  )
                ],
              ),


            );
          },
        ),
      );

    }
    );
  }
  void showSheet(context,String density,String pounds,String karat,String perpound,String total,String key,String grams,String volume,String price) {
    // Show a modal bottom sheet with the specified context and builder method.
    showMaterialModalBottomSheet(backgroundColor:Colors.black,context: context, builder: (BuildContext bc) {
      return Container(
        // Define padding for the container.
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        // Create a Wrap widget to display the sheet contents.
        child: Wrap(
          spacing: 30, // Add spacing between the child widgets.
          children:[
            // Add a container with height to create some space.
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      TextButton.icon(onPressed: (){
                        Navigator.pop(context);
                        FirebaseAccounts().db.collection("transactions").doc(key).delete();
                      },
                        icon: const Icon(Icons.delete_forever_sharp,color: Colors.red,), label: const Text("Delete"),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      TextButton.icon(onPressed: (){
                        Navigator.pop(context);

                        calculator(context,density,pounds,karat,perpound,total,key,grams,volume,price);
                      },
                        icon: const Icon(Icons.edit,color: Colors.orange,), label: const Text("Edit"),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      TextButton.icon(onPressed: (){},
                        icon: const Icon(Icons.share,color: Colors.green,), label: const Text("Share"),
                      )

                    ],
                  ),
                )

              ],

            ),
            const Divider(thickness: 5,color: Colors.black12,),
            // Add a text widget with a title for the sheet.
            const Text("Record Details ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            Container(height: 10), // Add some more space.
            const Divider(thickness: 1,color: Colors.black38,),

            // Add a text widget with a long description for the sheet.
            Column(
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
                    Text(pounds,
                      style: TextStyle(
                          color: Colors.grey[600], // Set the text color.
                          fontSize: 14 // Set the text size.
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1,color: Colors.black38,),
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
                const Divider(thickness: 1,color: Colors.black38,),

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
                const Divider(thickness: 1,color: Colors.black38,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Per Pound',
                      style: TextStyle(
                          color: Colors.grey[600], // Set the text color.
                          fontSize: 14 // Set the text size.
                      ),
                    ),
                    Text('$perpound',
                      style: TextStyle(
                          color: Colors.grey[600], // Set the text color.
                          fontSize: 14 // Set the text size.
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1,color: Colors.black38,),
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

            Container(height: 10), // Add some more space.
            // Add a row widget to display buttons for closing and reading more.
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align the buttons to the right.
              children: <Widget>[
                // Add a text button to close the sheet.
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.transparent,), // Make the button text transparent.
                  onPressed: (){
                    Navigator.pop(context); // Close the sheet.
                  },
                  child: Text("Close", style: TextStyle(color: Theme.of(context).colorScheme.primary)), // Add the button text.
                ),
                // Add an elevated button to read more.

              ],
            )
          ],
        ),
      );
    });
  }

}
