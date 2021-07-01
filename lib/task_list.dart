import 'package:flutter/material.dart';
import 'package:just_in_case_app/reminder_creation.dart';
import 'package:just_in_case_app/task_info.dart';

class ReminderListPage extends StatefulWidget {

  @override
  _ReminderListPageState createState() => _ReminderListPageState();
}

class _ReminderListPageState extends State<ReminderListPage> {
  var taskList = [];

  _sortList () {
    taskList.sort((a, b) => a.getDueDateTime().compareTo(b.getDueDateTime()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
                'assets/appLogo.png',
                fit: BoxFit.contain,
                height: 50
            ),
          ]
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              setState(() {
                print("Refreshed!");
              });
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: NetworkImage('https://www.seekpng.com/png/full/13-136905_index-of-wp-content-graphic-freeuse-download-real.png'),
        fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 60, bottom : 10),
        child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://cdn.picpng.com/logo/logo-emblem-symbol-bookmark-72047.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Next Task',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          minVerticalPadding: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TaskInfoPage(taskList[index])),
                            );
                          },
                          title: Container(
                            height: 70,
                            margin: EdgeInsets.only(left:5, right:5),
                            child: Card(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left:10, right: 10),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(taskList[index].getIcon()),
                                    )
                                  ),
                                  Text(
                                    '${taskList[index].getName()}',
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
                                          '${taskList[index].getFormattedDueDate()}',
                                        ),
                                        Text(
                                          '${taskList[index].getDueTime().format(context)}'
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                              )
                            ),
                          ),
                        ),
                        if (taskList.length > 1)
                          Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/04/21/11/logo-707109_960_720.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 40, bottom: 10),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Upcoming Tasks',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
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
                        MaterialPageRoute(builder: (context) => TaskInfoPage(taskList[index])),
                      );
                    },
                    title: Container(
                      height: 70,
                      margin: EdgeInsets.only(left:5, right:5),
                      child: Card(
                          child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left:10, right: 10),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(taskList[index].getIcon()),
                                    )
                                ),
                                Text(
                                  '${taskList[index].getName()}',
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
                                        '${taskList[index].getFormattedDueDate()}',
                                      ),
                                      Text(
                                          '${taskList[index].getDueTime().format(context)}'
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
      ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final task = await Navigator.push(
          context,
            MaterialPageRoute(builder: (context) => ReminderCreationPage()),
        );
        if (task != null) {
          taskList.add(task);
          if (taskList.length > 1)
            _sortList();
        }
        setState(() {

        });
      },
      tooltip: 'Add New Reminder',
      child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
