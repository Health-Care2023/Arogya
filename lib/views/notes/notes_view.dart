import 'package:flutter/material.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/crud/notes_service.dart';
import 'package:hello/views/notes/chat_view.dart';
import '../../constants/routes.dart';
import '../../enum/menu_action.dart';
import 'package:hello/services/auth/auth_exceptions.dart';
import 'package:hello/services/auth/auth_service.dart';
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
        title: const Text('Your Notes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(newNotesRoute);
              },
              icon: const Icon(Icons.add)),
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
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const ChatView(),
          //     fullscreenDialog: true,
          //   ),
          Navigator.of(context).pushNamed(chatroute);
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return Dialog(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20)),
          //       elevation: 16,
          //       child: Container(
          //           height: 700,
          //           child: const Column(
          //             children: [],
          //           )),
          //     );
          //   },
          // );
        },
      ),
      // body: FutureBuilder(
      //   future: _notesService.getorcreateUser(email: userEmail),
      //   builder: (context, snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.done:
      //         return StreamBuilder(
      //           stream: _notesService.allNotes,
      //           builder: (context, snapshot) {
      //             switch (snapshot.connectionState) {
      //               case ConnectionState.waiting:
      //               case ConnectionState.active:
      //                 if (snapshot.hasData) {
      //                   final allNotes = snapshot.data as List<DatabaseNote>;

      //                   return ListView.builder(
      //                     itemCount: allNotes.length,
      //                     itemBuilder: (context, index) {
      //                       final note = allNotes[index];
      //                       return ListTile(
      //                         title: Text(
      //                           note.text,
      //                           maxLines: 1,
      //                           softWrap: true,
      //                           overflow: TextOverflow.ellipsis,
      //                         ),
      //                       );
      //                     },
      //                   );
      //                 } else {
      //                   return CircularProgressIndicator();
      //                 }
      //               default:
      //                 return CircularProgressIndicator();
      //             }
      //           },
      //         );

      //       default:
      //         return CircularProgressIndicator();
      //     }
      //   },
      // ),
      // body: Container(
      //     alignment: Alignment.bottomRight,
      //     child: Column(
      //       children: [],
      //     )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(5, 50, 0, 0),
          children: [
            Text('Welcome ${patient?['id']}'),
            Text('Name: ${patient?['name']}'),
            Text('Mail: ${patient?['email']}'),
            Text('Aadhar No: ${patient?['aadhar_no']}'),
            Text('Gender: ${patient?['gender']}'),
          ],
        ),
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
