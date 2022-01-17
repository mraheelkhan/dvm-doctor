import 'package:dvm_doctor/activities/transactions.dart';
import 'package:dvm_doctor/models/Owner.dart';
import 'package:flutter/material.dart';
import 'package:dvm_doctor/activities/owners.dart';
import 'package:dvm_doctor/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgetOptions = [Transactions(), Owners()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Owners'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.logout), label: 'Logout'),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    if (index == 2) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      authProvider.logOut();
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }
}
