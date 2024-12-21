import 'package:flutter/material.dart';
import 'components/initpage.dart';
import 'controller/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'controller/accounts.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  String startup="";
  if(FirebaseAccounts().auth.currentUser!=null)
    {
      startup=Routes.dashboard;
    }
    else{
    startup=Routes.initial;
     }

  runApp(
      ChangeNotifierProvider(
        create: (BuildContext context)=>FirebaseAccounts(),
        child: MaterialApp(
          title: "Gafat Gold Calculator",
          routes: pages,
          initialRoute: startup,
          debugShowCheckedModeBanner: false,
           // home: ChangeNotifierProvider<FirebaseAccounts>(create: (BuildContext context)=>FirebaseAccounts(),child: Initpage(), )
        ),
      )
  );
}
