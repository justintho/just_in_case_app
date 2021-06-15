import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerPage extends StatefulWidget {
  const TimePickerPage({Key? key}) : super(key: key);

  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Time Picker')
        ),
        body: Column(
            children: [
              buildTimePicker(),
              ElevatedButton(
                child: Text(
                    'Done'
                ),
                onPressed: () {
                  print(dateTime);
                  Navigator.pop(context);
                },
              )
            ]
        )
    );
  }

  Widget buildTimePicker() => SizedBox(
    height: 300,
    child: CupertinoDatePicker(
      initialDateTime: dateTime,
      mode: CupertinoDatePickerMode.time,
      onDateTimeChanged: (dateTime) => setState(() => this.dateTime = dateTime),
    ),
  );
}
