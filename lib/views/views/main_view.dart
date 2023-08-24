import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/auth/bloc/auth_bloc.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';

import '../../constants/routes.dart';

import 'package:hello/db/database_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hello/views/emergency/emergency_page.dart';
import 'package:hello/views/emergency/appoinment_page.dart';
import 'package:hello/views/emergency/home_page.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  String get userEmail => Authservice.firebase().currentUser!.email!;
  late final SQLHelper _sqlHelper;
  late String imageString;
  Map<String, dynamic>? patient;
  int currentPageIndex = 0;
  String? _name;
  String? _email;
  int? _emergency;

  Uint8List? _image;

  @override
  void initState() {
    _sqlHelper = SQLHelper();

    refreshJournals();

    super.initState();
  }

  void refreshJournals() async {
    DatabaseUser user = await _sqlHelper.getUser(email: userEmail);
    setState(() {
      _name = user.name;
      _email = user.email;
      _image = user.image;
      _emergency = user.emergency;
    });
  }

  void onDataUpdated() {
    refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
            );
          },
        ),
        title: const Text('Arogya', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Stack(
                    children: <Widget>[
                      Icon(
                        Icons.notifications,
                        color: Color.fromARGB(255, 249, 246, 246),
                      ),
                    ],
                  ))
            ],
          )
        ],
        backgroundColor: Color.fromARGB(255, 5, 14, 82),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 5, 14, 82)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.truckMedical,
                color: Color.fromARGB(255, 181, 19, 8)),
            label: 'Emergency',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.stethoscope,
                color: Color.fromARGB(255, 5, 14, 82)),
            label: 'Appointment',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: [
            HomePage(appointment: () {
              setState(() {
                setState(() {
                  currentPageIndex = 2;
                });
              });
            }),
            EmergencyPage(
              onDataUpdated: onDataUpdated,
            ),
            const AppointmentPage(),
          ][currentPageIndex],
        ),
      ),
      floatingActionButton: Container(
        width: (MediaQuery.of(context).size.width) * (0.20),
        child: FloatingActionButton(
          child: const Icon(Icons.smart_toy_rounded),
          onPressed: () {
            Navigator.of(context).pushNamed(chatroute);
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(5, 50, 0, 0),
                children: <Widget>[
                  _image == null
                      ? Icon(Icons.account_circle_rounded)
                      : imageProfile(),
                  const SizedBox(height: 10),
                  Text(
                    "  ${_name.toString()} + ${_emergency.toString()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "  ${_email.toString()}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 30),

                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 18),
                    height: 0.5,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthEventUpdateProfile(onDataUpdated));
                    },
                    child: const Row(
                      children: [
                        SizedBox(width: 25),
                        Icon(Icons.person_2_outlined),
                        SizedBox(width: 20),
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 183, 18, 6),
                    width: 2.0,
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(20),
                child: Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            backgroundImage: MemoryImage(_image!),
          ),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log out',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        content: const Text('Are you sure You Want to Log out',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        actions: [
          ElevatedButton(
            child: const Text('Ok',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
          ),
          ElevatedButton(
            child: const Text('Cancel',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
