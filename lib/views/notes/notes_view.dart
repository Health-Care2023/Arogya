import 'package:flutter/material.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/crud/notes_service.dart';
import 'package:hello/views/profile_view.dart';

import '../../constants/routes.dart';
import '../../enum/menu_action.dart';

import 'package:hello/db/database_helper.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late final NotesService _notesService;
  Map<String, dynamic>? patient;
  int currentPageIndex = 0;

  @override
  void initState() {
    _notesService = NotesService();
    final user = Authservice.firebase().currentUser;
    final String? email = user?.email;
    fetchPatientDetails(email!);
    super.initState();
  }

  void fetchPatientDetails(String email) async {
    patient = await databaseHelper.getPatientByEmail(email);
    setState(() {});
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
                  ));
            },
          ),
          title: const Text('Arogya', style: TextStyle(color: Colors.white)),
          actions: [
            PopupMenuButton<MenuAction>(
              color: Colors.white,
              onSelected: (value) async {
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await Authservice.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginroute, (_) => false);
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('logout'),
                  ),
                ];
              },
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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(5, 50, 0, 0),
            children: [
              Icon(Icons.account_circle_rounded, size: 100),
              const SizedBox(height: 10),
              Text("  ${patient?['name']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text("   ${patient?['email']}",
                  style: const TextStyle(
                    fontSize: 15,
                  )),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 18),
                height: 0.5,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // Call your function here
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileView(patient?['email']),
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
              )
            ],
          ),
        ));
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
              child: const Text('Ok')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'))
        ],
      );
    },
  ).then((value) => value ?? false);
}
