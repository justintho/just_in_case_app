import 'package:flutter/material.dart';

class TaskInfoPage extends StatefulWidget {
  var taskInfo;

  TaskInfoPage(this.taskInfo);

  @override
  _TaskInfoPageState createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.taskInfo.getName()),
        ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image(
                  image: NetworkImage(widget.taskInfo.getIcon()),

                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  widget.taskInfo.getName(),
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Message: \"' + widget.taskInfo.getDescription() + '\"',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Deadline',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.taskInfo.getDueDateTime().month.toString().padLeft(2,'0')
                              + '/'
                              + widget.taskInfo.getDueDateTime().day.toString().padLeft(2,'0')
                              + '/'
                              + widget.taskInfo.getDueDateTime().year.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          widget.taskInfo.getDueTime().format(context),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Reminder',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.taskInfo.getDueDateTime().month.toString().padLeft(2,'0')
                              + '/'
                              + widget.taskInfo.getDueDateTime().day.toString().padLeft(2,'0')
                              + '/'
                              + widget.taskInfo.getDueDateTime().year.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          widget.taskInfo.getDueTime().format(context),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ]),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          iconSize: 50,
                          color: Colors.lightBlue,
                          onPressed: () {
                            print('hello');
                          },
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          iconSize: 50,
                          color: Colors.lightBlue,
                          onPressed: () {
                            print('there');
                          },
                        ),
                        Text(
                          'Delete',
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}
