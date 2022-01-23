import 'package:dvm_doctor/activities/TestPage.dart';
import 'package:dvm_doctor/activities/animals.dart';
import 'package:dvm_doctor/activities/dashboard.dart';
import 'package:dvm_doctor/providers/AnimalProvider.dart';
import 'package:flutter/material.dart';
import 'package:dvm_doctor/providers/AuthProvider.dart';
import 'package:dvm_doctor/providers/OwnerProvider.dart';
import 'package:dvm_doctor/activities/owners.dart';
import 'package:dvm_doctor/activities/home.dart';
import 'package:dvm_doctor/activities/login.dart';
import 'package:dvm_doctor/activities/register.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<OwnerProvider>(
                    create: (context) => OwnerProvider(authProvider)),
                ChangeNotifierProvider<AnimalProvider>(
                    create: (context) => AnimalProvider(authProvider))
              ],
              child: MaterialApp(
                  title: 'Welcome to DVM',
                  initialRoute: '/',
                  routes: {
                    '/': (context) {
                      final authProvider = Provider.of<AuthProvider>(context);
                      if (authProvider.isAuthenticated) {
                        return Home();
                      } else {
                        return Login();
                      }
                    },
                    '/login': (context) => Login(),
                    '/register': (context) => Register(),
                    '/home': (context) => Home(),
                    '/owners': (context) => Owners(),
                    '/animals': (context) => Animals(),
                    '/testPage': (context) => TestPage(),
                    '/dashboard': (context) => Dashboard(),
                  }));
        }));
  }
}
