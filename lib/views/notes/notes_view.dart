import 'package:flutter/material.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/crud/notes_service.dart';

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
          title: const Text('Arogya'),
          actions: [
            PopupMenuButton<MenuAction>(
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
          backgroundColor: const Color.fromARGB(255, 64, 255, 70),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.smart_toy_rounded),
          onPressed: () {
            Navigator.of(context).pushNamed(chatroute);
          },
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(5, 50, 0, 0),
            children: [
              const SizedBox(height: 120),
              Text(" Name : ${patient?['name']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Email :  ${patient?['email']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Aadhar No :  ${patient?['aadhar_no']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Date of birth : ${patient?['dateOfbirth']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Gender : ${patient?['gender']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Profession :  ${patient?['profession']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Address 1 : ${patient?['address1']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 20),
              Text(" Address 2 : ${patient?['address2']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 20),
              Text(" Address 3 : ${patient?['address3']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 20),
              Text(" District : ${patient?['District']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 20),
              Text(" WardNo : ${patient?['WordNo']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Pincode :  ${patient?['Pincode']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Alternate Phno 1 : ${patient?['Phone1']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              Text(" Alternate Phno 2 : ${patient?['Phone2']}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 251, 253, 254))),
              const SizedBox(height: 10),
              // Text('Welcome ${patient?['id']}'),
              // Text('Name: ${patient?['name']}'),
              // Text('Mail: ${patient?['email']}'),
              // Text('Aadhar No: ${patient?['aadhar_no']}'),
              // Text('Gender: ${patient?['gender']}'),
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
