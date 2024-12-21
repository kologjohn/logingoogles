import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/accounts.dart';
import '../utilities/menu.dart';
class Page3 extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<Page3> {
  final Stream<QuerySnapshot> _usersStream = FirebaseAccounts().db.collection('transactions').where('email',isEqualTo:'${FirebaseAccounts().auth.currentUser!.email}').snapshots();

  @override
  Widget build(BuildContext context) {


    return Consumer(

      builder: (context, value,  child) {

        return StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if(!snapshot.hasData)
              {
                return const Text('Loading Data',style: TextStyle(color: Colors.white),);
              }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return Padding(

              padding: const EdgeInsets.all(8.0),
              child: ListView(

                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Card(
                  shape: const RoundedRectangleBorder(),
                  elevation: 2,
                  color: Colors.white10,
                  child: ListTile(
                    onTap: (){
                        String grams="${data['grams']}";
                        String totals="${data['total']}";
                        String karats="${data['carat']}";
                        String perpound="${data['priceperpound']}";
                        String pounds="${data['pound']}";
                        String volume="${data['volume']}";
                        String densitys="${data['density']}";
                        String prices="${data['price']}";
                        Menus().showSheet(context,densitys,pounds,karats,perpound,totals,document.id,grams,volume,prices);
                       // Menus().showSheet(context, density, pounds, karat, perpound, total, key, grams, volume, price)
                      //  FirebaseAccounts().db.collection("transactions").doc(document.id).delete();
                    },
                    iconColor: Colors.amber,
                    leading: const Icon(Icons.calculate,color: Colors.white10,size: 50,),
                    title: Text("Grams ${data['grams']}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.amber),),
                    subtitle: Text("Volume ${data['volume']}",style: const TextStyle(color: Colors.white54),),
                    trailing:Text("${data['price']}",style:const TextStyle(color: Colors.white54))

                  ),

                    );

                })
                    .toList()
                    .cast(),
              ),
            );
          },
        );
      }
    );

  }
}
