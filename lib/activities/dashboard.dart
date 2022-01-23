import 'package:dvm_doctor/activities/Owners.dart';
import 'package:dvm_doctor/activities/TestPage.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Dashboard Coming soon',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () => {
                  // Navigator.of(context).pushNamed('/testPage')
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestPage()),
                  )
                },
                child: Text('owners'),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff3700b3),
                    minimumSize: Size(double.infinity, 36)),
              ),
            ]),
      ),
    );
  }
}
