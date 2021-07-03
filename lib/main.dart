import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_in_case_app/signup_page.dart';
import 'package:just_in_case_app/task_list.dart';
import 'package:google_fonts/google_fonts.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

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
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
              child: Image(
                image: AssetImage('assets/fullAppLogo.png'),
              )
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Login',
                style: GoogleFonts.amaticaSc(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  labelText:"E-mail"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText:"Password"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/tape.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text
                      ).then((value) {
                        print("Login success!");
                        Navigator.push(
                          context,
                          //MaterialPageRoute(builder: (context) => ReminderListPage()),
                          MaterialPageRoute(builder: (context) => ReminderListPage(emailController.text)),
                        );
                      }).catchError((error) {
                        print("Login failed!");
                        print(error.toString());
                      });
                },
                child: Text(
                  'Sign In',
                  style: GoogleFonts.neucha(
                      fontSize: 25,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/tape.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => ReminderListPage()),
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.neucha(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
