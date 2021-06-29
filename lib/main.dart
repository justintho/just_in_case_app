import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_in_case_app/reminder_list.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just In Case',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Just In Case App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Just In Case',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => ReminderListPage()),
                  MaterialPageRoute(builder: (context) => ReminderListPage()),
                );
              },
              child: Text(
                'Get Started!',
                style: TextStyle(fontSize: 25)
              ),
            )
          ],
        ),
      ),
    );
  }
}
