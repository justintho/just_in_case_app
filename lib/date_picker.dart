import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({Key? key}) : super(key: key);

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker')
      ),
      body: Column(
        children: [
          buildDatePicker(),
          Text(
            'Note: You cannot select dates that have already past.',
            style: TextStyle(color: Colors.red)
          ),
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
  
  Widget buildDatePicker() => SizedBox(
    height: 300,
    child: CupertinoDatePicker(
      minimumDate: dateTime,
      maximumYear: dateTime.year + 100,
      initialDateTime: dateTime,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) => setState(() => this.dateTime = dateTime),
    ),
  );
}
