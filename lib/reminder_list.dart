import 'package:flutter/material.dart';
import 'package:just_in_case_app/reminder_creation.dart';
import 'package:just_in_case_app/reminder_info.dart';

class ReminderListPage extends StatefulWidget {

  @override
  _ReminderListPageState createState() => _ReminderListPageState();
}

class _ReminderListPageState extends State<ReminderListPage> {
  var reminderList = [
    {
      'iconUrl' : 'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png',
      'task' : 'Wash Dishes',
      'date' : 'May 13, 2021',
      'time' : '8:00 am'
    },
    {
      'iconUrl' : 'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png',
      'task' : 'Wash Dishes',
      'date' : 'May 13, 2021',
      'time' : '8:00 am'
    },
    {
      'iconUrl' : 'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png',
      'task' : 'Wash Dishes',
      'date' : 'May 13, 2021',
      'time' : '8:00 am'
    },
    {
      'iconUrl' : 'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png',
      'task' : 'Wash Dishes',
      'date' : 'May 13, 2021',
      'time' : '8:00 am'
    },
    {
      'iconUrl' : 'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png',
      'task' : 'Doctor\'s Appointment',
      'date' : 'May 15, 2021',
      'time' : '8:00 pm'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder List'),
      ),
      body: ListView.builder(
        itemCount: reminderList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            minVerticalPadding: 0,
            visualDensity: VisualDensity(vertical: -4),
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReminderInfoPage()),
              );
            },
            title: Container(
              color: (index % 2 == 0 ? Colors.white : Colors.black12),
              height: 50,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left:10, right: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${reminderList[index]['iconUrl']}')
                    )
                  ),
                  Text(
                    '${reminderList[index]['task']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${reminderList[index]['date']}',

                        ),
                        Text(
                          '${reminderList[index]['time']}'
                        ),
                      ],
                    ),
                  ),
                ]
              )
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReminderCreationPage()),
        );
      },
      tooltip: 'Add New Reminder',
      child: Icon(Icons.add),
    ),
    );
  }
}
