import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:just_in_case_app/reminder_creation.dart';
import 'package:just_in_case_app/task_info.dart';
import 'package:google_fonts/google_fonts.dart';

class ReminderListPage extends StatefulWidget {
  String email;

  ReminderListPage(this.email);

  @override
  _ReminderListPageState createState() => _ReminderListPageState();
}

class _ReminderListPageState extends State<ReminderListPage> {
  String email = '';
  var taskList = [];

  _loadData() {
    FirebaseDatabase.instance.reference().child(email).once()
        .then((data) {
      print("Successfully loaded data!");
      var tempTaskList = [];
      taskList = [];
      data.value?.forEach((k, v) {
        tempTaskList.add(v);
      });
      for (int i = 0; i < tempTaskList.length; i++) {
        taskList.add(
            new Task(
                tempTaskList[i]['name'],
                tempTaskList[i]['description'],
                DateTime.parse(tempTaskList[i]['dueDateTime']),
                tempTaskList[i]['icon'],
                DateTime.parse(tempTaskList[i]['reminderDueDateTime']),
                tempTaskList[i]['id']
            )
        );
      }
      setState(() {
        _sortList();
      });
    }).catchError((error) {
      print("Failed to load the data!");
      print(error);
    });
  }

  _sortList() {
    taskList.sort((a, b) => a.getDueDateTime().compareTo(b.getDueDateTime()));
  }

  _updateList() {
    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].getDueDateTime().isBefore(DateTime.now())) {
        FirebaseDatabase.instance.reference()
            .child(email + '/task' + taskList[i].getID())
            .remove();
      }
    }
    _loadData();
  }

  @override
  void initState() {
    super.initState();
    String tempEmail = widget.email;
    email = tempEmail.split(".").join("");
    _loadData();
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
              _updateList();
              print("Refreshed");
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/appBackground.png'),
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
                              image: AssetImage('assets/bookmark.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Next Task',
                                style: GoogleFonts.neucha(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
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
                              MaterialPageRoute(builder: (context) => TaskInfoPage(taskList[index], email)),
                            ).then((value) => _updateList());
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
                                      style: GoogleFonts.rancho(fontSize: 30)
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
                                          style: GoogleFonts.courgette(),
                                        ),
                                        Text(
                                          '${taskList[index].getDueTime().format(context)}',
                                          style: GoogleFonts.courgette(),
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
                              image: AssetImage('assets/bookmark.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 40, bottom: 10),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Upcoming Tasks',
                                style: GoogleFonts.neucha(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
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
                        MaterialPageRoute(builder: (context) => TaskInfoPage(taskList[index], email)),
                      ).then((value) => _updateList());
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
                                  style: GoogleFonts.rancho(fontSize: 30),
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
                                        style: GoogleFonts.courgette(),
                                      ),
                                      Text(
                                        '${taskList[index].getDueTime().format(context)}',
                                        style: GoogleFonts.courgette(),
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
          FirebaseDatabase.instance.reference().child(email + "/task" + task.getID()).set(
              {
                "name": task.getName(),
                "description" : task.getDescription(),
                "dueDateTime" : task.getDueDateTime().toString(),
                "icon" : task.getIcon(),
                "reminderDueDateTime" : task.getReminderDueDateTime().toString(),
                "id" : task.getID()
              }
          ).then((value) {
            print("Successfully added to database!");
          }).catchError((error) {
            print("Failed to add to database!");
            print(error);
          });
          _updateList();
        }
      },
      tooltip: 'Add New Reminder',
      child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
