import 'package:goldcalcus/components/initpage.dart';

import '../components/signup.dart';
import '../components/login.dart';
import '../components/dashboard.dart';
import '../controller/accounts.dart';
import '../main.dart';

class Routes {
  static String userlogin = "login";
  static String usersignup = "signup";
  static String dashboard = "dashboard";
  static String home = "home";
  static String initial = "initial";
}

final pages = {
  Routes.dashboard: (context) => const Dashboard(),
  Routes.usersignup: (context) => Signup(),
  Routes.userlogin: (context) => Login(),
  Routes.home: (context) => const Dashboard(),
  Routes.initial: (context) => Initpage(),
};
