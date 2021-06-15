import 'package:flutter/material.dart';
import 'package:just_in_case_app/date_picker.dart';
import 'package:just_in_case_app/time_picker.dart';

class ReminderCreationPage extends StatefulWidget {
  const ReminderCreationPage({Key? key}) : super(key: key);

  @override
  _ReminderCreationPageState createState() => _ReminderCreationPageState();
}

class _ReminderCreationPageState extends State<ReminderCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create A New Reminder'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text(
              'Pick Date'
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DatePickerPage()),
              );
            }
          ),
          ElevatedButton(
              child: Text(
                  'Pick Time'
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimePickerPage()),
                );
              }
          )
        ]
      )
    );
  }
}
