import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controller/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dbModels/dbcrud.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class FirebaseAccounts extends ChangeNotifier {
  //FirebaseAccounts({name,age,hometown});
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  bool loginstatus = false;
  String name = "";
  int age = 0;
  String hometown = "";
  String message = "";
  double totalgram = 0;
  bool progress = false;
  String startapp = "dashboard";

  googlesignup(BuildContext context) async {
    progress = true;
    try {
      progress = true;
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      print(googleSignInAccount);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final dt = await auth.signInWithCredential(credentials);
      progress = false;
      loginstatus = true;
      String? name = auth.currentUser!.displayName;
      String? email = auth.currentUser!.email;
      //print(name);
      final existdata =
          await Dbinsert().db.collection("users").doc(email).get();
      if (existdata.exists) {
        String phone = existdata.data()!['phone'];
        Navigator.pushNamed(context, Routes.dashboard);
        //await setsession(name!, email!, phone);
        // if(await SessionManager().containsKey("pin"))
        // {
        //   Navigator.pushNamed(context, Routes.pinscreen);
        //
        // }
        // else
        // {
        //   Navigator.pushNamed(context, Routes.pinsetup);
        //
        // }
      } else {
        //googlebtn=true;
        //  await SessionManager().set("googlebtn", true);
        Navigator.pushNamed(context, Routes.usersignup);
      }
      // setsession(name!, email!);
      notifyListeners();
    } catch (e) {
      print("Error: $e");
      //errorMsgs=e.message!;
    }
    notifyListeners();
  }

  Future<User?> signInWithGoogles({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    bool status = false;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      setpreference("Kolog John", "Zanlerigu", 20, true);
      Navigator.pushNamed(context, Routes.dashboard);

      status = true;
    } catch (e) {
      //message="${e.toString()}";
      //print("Can not login $e");
    }
    notifyListeners();
    return status;
  }

  Future<String> signup(BuildContext context, String email, String password,
      String name, String phone) async {
    String? status;
    try {
      if (auth.currentUser != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool("name", true);
        sharedPreferences.setString("phone", phone);
        await Dbinsert().addNewUser(name, email, phone, password);
        Navigator.pushNamed(context, Routes.dashboard);
        status = "Account Created Successfully";
      } else {
        await FirebaseAccounts()
            .auth
            .createUserWithEmailAndPassword(email: email, password: password);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool("name", true);
        sharedPreferences.setString("phone", phone);
        await Dbinsert().addNewUser(name, email, phone, password);
        Navigator.pushNamed(context, Routes.dashboard);
        status = "Account Created Successfully";
      }
    } on FirebaseAuthException catch (e) {
      status = e.message.toString();
      // print("Can Not Create Account $e");
    }
    notifyListeners();
    return status;
  }

  Future<void> logout(BuildContext context) async {
    try {
      await auth.signOut();
      Navigator.popAndPushNamed(context, Routes.initial);
    } catch (e) {
      print("Error Signing Out $e");
    }
  }

  Future innitial(BuildContext context) async {
    final user = auth.currentUser;
    if (user != null) {
      //print("Already Login ${user.email}");
      Navigator.pushNamed(context, Routes.dashboard);
    }
    notifyListeners();
  }

  sessions<List>(String nametxt, int agetxt, String hometowntxt) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.get("status");
    loginstatus = sharedPreferences.getBool("status")!;
    nametxt = sharedPreferences.getString("name")!;
    agetxt = sharedPreferences.getInt("age")!;
    hometowntxt = sharedPreferences.getString("home")!;
    // hometown=sharedPreferences.getString("hometown")!;
    notifyListeners();
    return [nametxt, agetxt, hometowntxt, loginstatus];
  }

  Future<void> setpreference(
      String nametxt, String hometowntxt, int agenum, bool status) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("status", status);
    sharedPreferences.setInt("age", agenum);
    sharedPreferences.setString("name", nametxt);
    sharedPreferences.setString("home", hometowntxt);
    notifyListeners();
  }

  double truncateToDecimalPlaces(num value, int fractionalDigits) {
    double converted = 0;
    if (value > 0) {
      converted = (value * pow(10, fractionalDigits)).truncate() /
          pow(10, fractionalDigits);
    }
    return converted;
  }

  List density(double grams, double volume, double price) {
    double finalDesity = 0;
    double finalKarat = 0;

    if (volume > 0) {
      double dens = (grams / volume);
      finalDesity = truncateToDecimalPlaces(dens, 2);
    }
    if (finalDesity > 0) {
      double karat = ((finalDesity - 10.51) * (52.838)) / (finalDesity);
      finalKarat = truncateToDecimalPlaces(karat, 2);
    }

    double pounds = ((grams / 7.75));
    double finalPounds = truncateToDecimalPlaces(pounds, 2);
    double perpound = (finalKarat * price) / (23);
    double finalPerpounds = truncateToDecimalPlaces(perpound, 2);
    double totalamount = finalPerpounds * finalPounds;
    double finalTotalamount = truncateToDecimalPlaces(totalamount, 0);
    notifyListeners();
    return [
      finalDesity,
      finalPounds,
      finalKarat,
      finalPerpounds,
      finalTotalamount
    ];
  }

  int updateRecord(
      double grams,
      double volume,
      double price,
      double density,
      double pounds,
      double karat,
      double perpounds,
      double total,
      String email,
      String key) {
    int status = 2;
    final data = {
      "email": email,
      "grams": grams,
      "volume": volume,
      "price": price,
      "density": density,
      "pound": pounds,
      "carat": karat,
      "priceperpound": perpounds,
      "total": total
    };
    try {
      db.collection("transactions").doc(key).set(data).then((value) {
        status = 1;
      });
      //
      // db.collection("transactions").add(data).then((value) {
      //   status=1;
      //   //  print("Data:${value.id}");
      // });
    } catch (e) {
      status = 0;
      print("Error Saving Records $e");
    }
    return status;
  }

  addNewrecord(
      double grams,
      double volume,
      double price,
      double density,
      double pounds,
      double karat,
      double perpounds,
      double total,
      String email) async {
    int status = 2;
    final data = {
      "email": email,
      "grams": grams,
      "volume": volume,
      "price": price,
      "density": density,
      "pound": pounds,
      "carat": karat,
      "priceperpound": perpounds,
      "total": total
    };
    try {
      //int cc= db.collection("transactions").count();
      // print(db.collection("transactions").count());
      //  db.collection("transactions").doc("dd").set(data).then((value) {
      //    status=1;
      //  });

      await db.collection("transactions").add(data).then((value) {
        status = 1;
        //  print("Data:${value.id}");
      });
    } catch (e) {
      status = 0;
      print("Error Saving Records $e");
    }
    //return  status;
  }

  Future<double> totalgrams() async {
    try {
      db
          .collection("transactions")
          .where('email',
              isEqualTo: '${FirebaseAccounts().auth.currentUser!.email}')
          .get()
          .then((value) {
        for (var i in value.docs) {
          db
              .collection('transactions')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              totalgram += doc['Grams'];
              print(totalgram);
              //data.add({doc['Grams']});
            }
          });
        }
      });
    } catch (e) {}
    notifyListeners();
    return totalgram;
  }

  Future<List> getTransactions() async {
    final List data = [];
    double totalgram = 0;
    double totalamount = 0;

    try {
      db.collection("transactions").get().then((value) {
        for (var i in value.docs) {
          db
              .collection('transactions')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              totalgram += doc['Grams'];
              totalamount += doc['total'];
              //data.add({doc['Grams']});
            }
          });
        }
      });
    } catch (e) {}
    data.add(totalgram);
    data.add(totalamount);
    return data;
  }
}

//multiform
