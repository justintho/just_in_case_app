import 'package:flutter/material.dart';

class ReminderInfoPage extends StatefulWidget {
  const ReminderInfoPage({Key? key}) : super(key: key);

  @override
  _ReminderInfoPageState createState() => _ReminderInfoPageState();
}

class _ReminderInfoPageState extends State<ReminderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Information'),
      ),
    );
  }
}
