import 'package:flutter/material.dart';
import 'package:just_in_case_app/reminder_creation.dart';

class ReminderListPage extends StatefulWidget {

  @override
  _ReminderListPageState createState() => _ReminderListPageState();
}

class _ReminderListPageState extends State<ReminderListPage> {
  var reminderList = [];

  _sortList () {
    reminderList.sort((a, b) => a.getDueDateTime().compareTo(b.getDueDateTime()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: reminderList.length == 0 ? Center(
        child: Container(
          margin: EdgeInsets.only(right: 25, left: 25),
          child: Text(
            'No Tasks Right Now... But You Can Add Some!',
            style: TextStyle(fontSize: 30)
          ),
        ),
      ) :
      ListView.builder(
          itemCount: reminderList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Next Task',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity(vertical: -4),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReminderInfoPage(
                          taskName: reminderList[index].getName(),
                          taskDescription: reminderList[index].getDescription(),
                          taskDueDate: reminderList[index].getDueDateTime(),
                          taskDueTime: reminderList[index].getDueTime(),
                          taskIcon: reminderList[index].getIcon()
                        )),
                      );
                    },
                    title: Container(
                      height: 60,
                      margin: EdgeInsets.only(left:5, right:5),
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left:10, right: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(reminderList[index].getIcon()),
                              )
                            ),
                            Text(
                              '${reminderList[index].getName()}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${reminderList[index].getFormattedDueDate()}',
                                  ),
                                  Text(
                                    '${reminderList[index].getDueTime().format(context)}'
                                  ),
                                ],
                              ),
                            ),
                          ]
                        )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      reminderList.length > 1 ? 'Upcoming Tasks' : 'No Upcoming Tasks',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ]
              );
            }
            return ListTile(
              minVerticalPadding: -3,
              visualDensity: VisualDensity(vertical: -4),
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReminderInfoPage(
                    taskName: reminderList[index].getName(),
                    taskDescription: reminderList[index].getDescription(),
                    taskDueDate: reminderList[index].getDueDateTime(),
                    taskDueTime: reminderList[index].getDueTime(),
                    taskIcon: reminderList[index].getIcon()
                  )),
                );
              },
              title: Container(
                height: 60,
                margin: EdgeInsets.only(left:5, right:5),
                child: Card(
                    child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left:10, right: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(reminderList[index].getIcon()),
                              )
                          ),
                          Text(
                            '${reminderList[index].getName()}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${reminderList[index].getFormattedDueDate()}',
                                ),
                                Text(
                                    '${reminderList[index].getDueTime().format(context)}'
                                ),
                              ],
                            ),
                          ),
                        ]
                    )
                ),
              ),
            );
        }
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final task = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReminderCreationPage()),
        );
        if (task != null) {
          reminderList.add(task);
          if (reminderList.length > 1)
            _sortList();
        }
        setState(() {

        });
      },
      tooltip: 'Add New Reminder',
      child: Icon(Icons.add),
    ),
    );
  }
}

class ReminderInfoPage extends StatefulWidget {
  final String taskName;
  final String taskDescription;
  final DateTime taskDueDate;
  final TimeOfDay taskDueTime;
  final String taskIcon;

  const ReminderInfoPage({
    Key? key,
    required this.taskName,
    required this.taskDescription,
    required this.taskDueDate,
    required this.taskDueTime,
    required this.taskIcon
  }) : super(key: key);

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
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  taskName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )
        )
    );
  }
}
