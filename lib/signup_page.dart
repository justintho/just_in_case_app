import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Sign Up',
                  style: GoogleFonts.amaticaSc(fontSize: 30, fontWeight: FontWeight.bold),
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: TextField(
                controller: emailController,
                style: GoogleFonts.neucha(fontSize: 20),
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
                style: GoogleFonts.neucha(fontSize: 20),
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
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text
                      ).then((value) {
                        print("Successfully signed up!");
                        Navigator.pop(context);
                      }).catchError((error) {
                        print("Failed to sign up!");
                        print(error.toString());
                      });
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
