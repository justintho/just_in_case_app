import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';

import 'main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject =
BehaviorSubject<String?>();
String? selectedNotificationPayload;
String taskName = "";
String taskDescription = "";
String taskDueDate = "";
String taskTime = "";

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_logo_only');

  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload);
      });
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

class Task {
  String name = "";
  String description = "";
  DateTime dueDateTime = DateTime.now();
  String iconPath = 'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png';
  DateTime reminderDueDateTime = DateTime.now();
  String id = "";

  Task (String taskName, String taskDescription, DateTime taskDueDateTime, String icon, DateTime reminderDueDateTime, String id) {
    name = taskName;
    if (taskDescription != "")
      description = taskDescription;
    dueDateTime = taskDueDateTime;
    iconPath = icon;
    this.reminderDueDateTime = reminderDueDateTime;
    this.id = id;
  }

  String getName() {
    return name;
  }

  String getDescription() {
    if (description == "")
      return "N/A";
    else
      return description;
  }

  DateTime getDueDateTime() {
    return dueDateTime;
  }

  TimeOfDay getDueTime() {
    return TimeOfDay.fromDateTime(dueDateTime);
  }

  String getIcon() {
    return iconPath;
  }

  DateTime getReminderDueDateTime() {
    return reminderDueDateTime;
  }

  TimeOfDay getReminderDueTime() {
    return TimeOfDay.fromDateTime(reminderDueDateTime);
  }

  String getID() {
    return id;
  }

  String getFormattedDueDate() {
    return '${dueDateTime.month.toString().padLeft(2,'0')}/${dueDateTime.day.toString().padLeft(2,'0')}/${dueDateTime.year.toString()}';
  }
  String getFormattedReminderDueDate() {
    return '${reminderDueDateTime.month.toString().padLeft(2,'0')}/${reminderDueDateTime.day.toString().padLeft(2,'0')}/${reminderDueDateTime.year.toString()}';
  }
}

class ReminderCreationPage extends StatefulWidget {
  const ReminderCreationPage({Key? key}) : super(key: key);

  @override
  _ReminderCreationPageState createState() => _ReminderCreationPageState();
}

class _ReminderCreationPageState extends State<ReminderCreationPage> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  String icon = 'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png';
  String _selected = '';
  String errorMessage = '';

  var iconList = [
    'https://cdn0.iconfinder.com/data/icons/logistics-delivery-colored-2/128/32-512.png',
    'https://www.seekpng.com/png/detail/97-972664_image-transparent-background-white-phone-icon.png',
    'https://www.nicepng.com/png/detail/820-8205745_nutrition-and-dietetics-circle-meeting-icon-png.png',
    'https://image.flaticon.com/icons/png/512/1946/1946716.png',
    'https://www.nicepng.com/png/detail/867-8678512_doctor-icon-physician.png',
    'https://visitbrookhavenms.com/wp-content/uploads/2015/06/eat-icon-1.png',
    'http://topcommercialcleaning.com/wp-content/uploads/2016/03/icon2.png',
    'https://i7.uihere.com/icons/735/293/113/christmas-tree-a3c12113ad2b103fb3f25f084e52d233.png',
    'https://www.logiwa.com/hubfs/Website%20Assets/Careers/vacation.png',
    'https://www.irantravelservice.com/images/icon/plane.png',
    'https://pics.freeicons.io/uploads/icons/png/9835516671598536281-512.png',
    'https://icons.iconarchive.com/icons/martz90/circle-addon1/256/runkeeper-icon.png'
  ];
  var iconNameList = [
    'Task (default)',
    'Phone',
    'Meeting',
    'Hangout',
    'Health',
    'Food',
    'Chore',
    'Holiday',
    'Vacation',
    'Travel',
    'Workout',
    'Exercise'
  ];

  @override
  void initState() {
    super.initState();
    initialize();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _selected = iconNameList[0];
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MyHomePage(title: 'Just In Case'),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, '/myHomePage');
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bookmark.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Create A Task',
                    style: GoogleFonts.neucha(fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Task Name',
                    style: GoogleFonts.neucha(fontSize: 25, fontWeight: FontWeight.bold)
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: myController1,
                      maxLength: 20,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: '*Required* (up to 20 characters)',
                          hintStyle: GoogleFonts.neucha(fontStyle: FontStyle.italic)
                      ),
                        style: GoogleFonts.neucha(fontSize: 20)
                    ),
                  )
                ),
                Container(
                    child: Text(
                        'Message',
                        style: GoogleFonts.neucha(fontSize: 25, fontWeight: FontWeight.bold)
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextField(
                        controller: myController2,
                          maxLength: 50,
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: '*Optional* (up to 50 characters)',
                            hintStyle: GoogleFonts.neucha(fontStyle: FontStyle.italic)
                        ),
                          style: GoogleFonts.neucha(fontSize: 20)
                      ),
                    )
                ),
                Container(
                    child: Text(
                        'Icon',
                        style: GoogleFonts.neucha(fontSize: 25, fontWeight: FontWeight.bold)
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selected,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        onChanged: (newValue) {
                          setState(() {
                            _selected = newValue!;
                          });
                        },
                        items: iconNameList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                                value,
                                style: GoogleFonts.neucha(fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                              'Date',
                              style: GoogleFonts.neucha(fontSize: 25, fontWeight: FontWeight.bold)
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                              ),
                              child: Text(
                                  '${_date.month.toString().padLeft(2,'0')}/${_date.day.toString().padLeft(2,'0')}/${_date.year.toString()}',
                                  style: GoogleFonts.courgette(fontSize: 20)
                              ),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 10),
                                ).then((date) {
                                  setState(() {
                                    _date = date!;
                                  });
                                });
                              }
                          )
                        ]
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                              'Time',
                              style: GoogleFonts.neucha(fontSize: 25, fontWeight: FontWeight.bold)
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                              ),
                              child: Text(
                                  '${_time.format(context)}',
                                  style: GoogleFonts.courgette(fontSize: 20)
                              ),
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((time) {
                                  setState(() {
                                    _time = time!;
                                  });
                                });
                              }
                          )
                        ]
                      ),
                    ),
                  )
                ]
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.red.withOpacity(1),
                        fontSize: 18
                      )
                    ),
                    Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/tape2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: TextButton(
                            child: Text(
                              'Create',
                              style: GoogleFonts.neucha(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold
                              )
                            ),
                            onPressed: () {
                              DateTime _dateTime = DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
                              if (myController1.text.length != 0 && DateTime.now().isBefore(_dateTime)) {
                                errorMessage = '';
                                taskName = myController1.text;
                                if (myController2.text.length != 0)
                                  taskDescription = myController2.text;
                                icon = determineIcon(_selected);
                                String timestamp = new DateTime.now().millisecondsSinceEpoch.toString();
                                Task task = Task(taskName, taskDescription, _dateTime, icon, _dateTime, timestamp);
                                _scheduleNotification(int.parse(timestamp));
                                taskDescription = "";
                                Navigator.pop(context, task);
                              }
                              else
                                if (myController1.text.length == 0)
                                  errorMessage = 'Please enter a task name.';
                                else
                                  errorMessage = 'Invalid due date/time.';
                                setState(() {

                                });
                            },
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]
        ),
      )
    );
  }

  Future<void> _scheduleNotification(int timestamp) async {
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        timestamp,
        taskName,
        taskDescription == "" ? "<No Message>" : taskDescription,
        new DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true
    );
  }

  String determineIcon(String iconName) {
    if (iconName == 'Task (default)')
      return iconList[0];
    else if (iconName == 'Phone')
      return iconList[1];
    else if (iconName == 'Meeting')
      return iconList[2];
    else if (iconName == 'Hangout')
      return iconList[3];
    else if (iconName == 'Health')
      return iconList[4];
    else if (iconName == 'Food')
      return iconList[5];
    else if (iconName == 'Chore')
      return iconList[6];
    else if (iconName == 'Holiday')
      return iconList[7];
    else if (iconName == 'Vacation')
      return iconList[8];
    else if (iconName == 'Travel')
      return iconList[9];
    else if (iconName == 'Workout')
      return iconList[10];
    else
      return iconList[11];
  }
}

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) {
    return DateTime(this.year, this.month, this.day, time.hour, time.minute);
  }
}
