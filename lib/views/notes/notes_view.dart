import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/auth/bloc/auth_bloc.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';

import 'package:hello/services/chat/assets_manager.dart';
import 'package:hello/views/profile_view.dart';

import '../../constants/routes.dart';

import 'package:hello/db/database_helper.dart';

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
    });
  }

  void onDataUpdated() {
    refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_online),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.place),
            label: 'Maps',
          ),
          NavigationDestination(
            icon: Icon(Icons.medication),
            label: 'Medicines',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Home', style: TextStyle(fontSize: 30)),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Bookings', style: TextStyle(fontSize: 30)),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Maps', style: TextStyle(fontSize: 30)),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Medicines', style: TextStyle(fontSize: 30)),
        ),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.smart_toy_rounded),
        onPressed: () {
          Navigator.of(context).pushNamed(chatroute);
        },
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
                    "  ${_name.toString()}",
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
                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 18),
                    height: 0.5,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileView(
                          onDataUpdated: onDataUpdated,
                        ),
                      ));
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
                    color: Colors.red,
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
        title: const Text('Log out'),
        content: const Text("Are you sure You Want to Log out"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Ok'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}
