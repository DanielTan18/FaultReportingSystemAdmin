import 'package:flutter/material.dart';
import 'package:fyp_admin/providers/app.dart';
import 'package:fyp_admin/providers/faultreport.dart';
import 'package:fyp_admin/providers/user.dart';
import 'package:fyp_admin/screens/login.dart';
import 'package:fyp_admin/screens/view_reports.dart';
import 'package:fyp_admin/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: FaultReportProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fault Reporting App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return ViewReportsScreen();
      default:
        return LoginScreen();
    }
  }
}
