import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/accounts.dart';
import './piechart.dart';
import './chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAccounts>(
      builder: (BuildContext context, FirebaseAccounts value, Widget? child) {
        final Stream<QuerySnapshot> usersStream = value.db
            .collection('transactions')
            .where('email',
                isEqualTo: '${FirebaseAccounts().auth.currentUser!.email}')
            .snapshots();

        return StreamBuilder<QuerySnapshot>(
            stream: usersStream,
            builder: (context, snapshot) {
              double tgrams = 0;
              double tamount = 0;
              if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data!.size; i++) {
                  tgrams += snapshot.data!.docs[i]['grams'];
                  tamount += snapshot.data!.docs[i]['total'];
                }
                //tgrams=snapshot.data!.docs[0]['Grams'];
              }
              return Container(
                color: Colors.black,
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  // children: snapshot.data!.docs.map((DocumentSnapshot document)
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 200,
                            child: GestureDetector(
                              onTap: () async {
                                print(await value.totalgrams());
                              },
                              child: Card(
                                color: Colors.white10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.balance,
                                      size: 40,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "$tgrams",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white54),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Text(
                                      "Grams",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 200,
                            child: Card(
                              color: Colors.white10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.monetization_on,
                                    size: 40,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "$tamount",
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white54),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        Card(
                          elevation: 20,
                          color: Colors.white10,
                          child: Column(
                            children: [
                              Pie(context, tgrams, tamount),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.bookmark_rounded,
                                      color: Colors.orange,
                                      size: 30,
                                    ),
                                    const Text(
                                      "Sales",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Icon(
                                      Icons.bookmark_rounded,
                                      color: Colors.green[900],
                                      size: 30,
                                    ),
                                    const Text(
                                      "Purchase",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              );
            });
      },
    );
  }
}

//chart
