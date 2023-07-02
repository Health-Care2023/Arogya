import 'package:flutter/material.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/crud/notes_service.dart';
import 'package:hello/views/notes/chat_view.dart';
import '../../constants/routes.dart';
import '../../enum/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;

  String get userEmail => Authservice.firebase().currentUser!.email!;
  @override
  void initState() {
    _notesService = NotesService();

    super.initState();
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
          Navigator.of(context).pushNamed(
          chatroute
          );
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
