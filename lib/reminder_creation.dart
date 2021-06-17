import 'package:flutter/material.dart';
import 'dart:async';

class ReminderCreationPage extends StatefulWidget {
  const ReminderCreationPage({Key? key}) : super(key: key);

  @override
  _ReminderCreationPageState createState() => _ReminderCreationPageState();
}

class _ReminderCreationPageState extends State<ReminderCreationPage> {
  DateTime? _dateTime;
  TimeOfDay? _time;

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
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 10),
              ).then((date) {
                setState(() {
                  _dateTime = date;
                });
              });
            }
          ),
          Text(
            _dateTime == null ? 'Please select a date.' :
              'Date: ${_dateTime!.month.toString().padLeft(2,'0')}/${_dateTime!.day.toString().padLeft(2,'0')}/${_dateTime!.year.toString()}'
          ),
          ElevatedButton(
              child: Text(
                  'Pick Time'
              ),
              onPressed: () {
                showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                ).then((time) {
                  setState(() {
                    _time = time;
                  });
                });
              }
          ),
          Text(
            _time == null ? 'Please select a time.' :
               'Time: ${_time!.format(context)}'
          )
        ]
      )
    );
  }
}
