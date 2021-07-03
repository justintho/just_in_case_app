import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskInfoPage extends StatefulWidget {
  var taskInfo;
  String email;

  TaskInfoPage(this.taskInfo, this.email);

  @override
  _TaskInfoPageState createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage> {

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Delete ' + widget.taskInfo.getName()) ,
              content: Text("Are you sure you want to delete this?"),
              actions: [
                TextButton(onPressed: () {
                Navigator.pop(context);
                },
                  child: Text(
                    'Cancel'
                  )
                ),
                TextButton(onPressed: () {
                  FirebaseDatabase.instance.reference()
                      .child(widget.email + "/task" + widget.taskInfo.getID())
                      .remove().whenComplete(() => Navigator.pop(context))
                      .then((value) {
                        print("Deleted successfully!");
                      }).catchError((error) {
                        print("Could not delete!");
                        print(error);
                      });
                  Navigator.pop(context);
                },
                    child: Text(
                        'Delete'
                    )
                ),
              ]
          );
        });
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
          )
        ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 60, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/postItNote.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 20, top: 60, bottom: 20),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image(
                                image: NetworkImage(widget.taskInfo.getIcon()),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            margin: EdgeInsets.only(top: 60, bottom: 20),
                            child: Text(
                              widget.taskInfo.getName(),
                              style: GoogleFonts.neucha(fontSize: 30, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Message: \"' + widget.taskInfo.getDescription() + '\"',
                          style: GoogleFonts.rancho(fontSize: 25, fontStyle: FontStyle.italic),
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
                                  style: GoogleFonts.amaticaSc(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.taskInfo.getDueDateTime().month.toString().padLeft(2,'0')
                                      + '/'
                                      + widget.taskInfo.getDueDateTime().day.toString().padLeft(2,'0')
                                      + '/'
                                      + widget.taskInfo.getDueDateTime().year.toString(),
                                  style: GoogleFonts.courgette(fontSize: 20),
                                ),
                                Text(
                                  widget.taskInfo.getDueTime().format(context),
                                  style: GoogleFonts.courgette(fontSize: 20),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  'Reminder',
                                  style: GoogleFonts.amaticaSc(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.taskInfo.getDueDateTime().month.toString().padLeft(2,'0')
                                      + '/'
                                      + widget.taskInfo.getDueDateTime().day.toString().padLeft(2,'0')
                                      + '/'
                                      + widget.taskInfo.getDueDateTime().year.toString(),
                                  style: GoogleFonts.courgette(fontSize: 20),
                                ),
                                Text(
                                  widget.taskInfo.getDueTime().format(context),
                                  style: GoogleFonts.courgette(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                      ),
                    ],
                  ),
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
                            color: Colors.black,
                            onPressed: () {
                              print('hello');
                            },
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            iconSize: 50,
                            color: Colors.black,
                            onPressed: () {
                              _showDeleteDialog();
                            },
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      )
    );
  }
}
