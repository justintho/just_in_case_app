import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_in_case_app/task_list.dart';

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
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black
          )
        )
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 100),
              child: Image(
                image: AssetImage('assets/fullAppLogo.png'),
              )
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
