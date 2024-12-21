import 'package:flutter/material.dart';
import 'package:goldcalcus/components/sell.dart';
import 'package:provider/provider.dart';
import '../controller/accounts.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import '../components/page3.dart';
import '../utilities/menu.dart';
import '../utilities/home.dart';
import 'calculator.dart';

enum SingingCharacter { lafayette, jefferson }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<Dashboard> {
  int currentPageIndex = 0;

  late List datalist;

  //final _salesform=GlobalKey<FormState>();
  final GlobalKey<FormState> _salesform = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //sessioninnitil();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      barrierColor: Colors.black26,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 1,
              centerTitle: true,
              shadowColor: Colors.white54,
              backgroundColor: Colors.black,
              title: const Text(
                "Gold Calculator ",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (text) async {
                    if (text == "Logout") {
                      // final pro=ProgressHUD.of(context);
                      // pro!.showWithText("Please wait..");

                      await FirebaseAccounts().logout(context);
                      // pro!.dismiss();
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'email',
                      child: Row(
                        children: [
                          const Icon(Icons.email),
                          Text("${FirebaseAccounts().auth.currentUser?.email}")
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'name',
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          Text(
                              "${FirebaseAccounts().auth.currentUser?.displayName}")
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Logout',
                      child: Row(
                        children: [Icon(Icons.logout), Text(' Logout')],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: Theme(
              data: ThemeData.dark(),
              child: NavigationBar(
                elevation: 10,
                backgroundColor: const Color.fromRGBO(0, 10, 14, 1),
                shadowColor: Colors.white,
                surfaceTintColor: Colors.white,
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                indicatorColor: Colors.white12,
                selectedIndex: currentPageIndex,
                destinations: const <Widget>[
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.home,
                      color: Colors.amber,
                    ),
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.orangeAccent,
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.calculate,
                      color: Colors.amber,
                    ),
                    label: 'Calculator',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.archive_outlined,
                      color: Colors.amber,
                    ),
                    label: 'Records',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.storage,
                      color: Colors.amber,
                    ),
                    label: 'Sell',
                  ),
                ],
              ),
            ),
            body: Consumer<FirebaseAccounts>(
              builder: (context, data2, child) {
                return <Widget>[
                  Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: const Home()),
                  ),
                  Calculator(),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Page3(),
                  ),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const Text(
                      "Coming Soon..",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ][currentPageIndex];
              },
            ),
          ),
        ),
      ),
    );
  }
}
