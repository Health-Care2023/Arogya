import 'package:flutter/material.dart';
import 'package:hello/constants/constants.dart';
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
<<<<<<< HEAD
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
      // drawer: Drawer(
      //   backgroundColor: Colors.amber,
      //   child: ListView(
      //     padding: EdgeInsets.fromLTRB(5, 50, 0, 0),
      //     children: [
      //       Text('Welcome ${patient?['id']}'),
      //       Text('Name: ${patient?['name']}'),
      //       Text('Mail: ${patient?['email']}'),
      //       Text('Aadhar No: ${patient?['aadhar_no']}'),
      //       Text('Gender: ${patient?['gender']}'),
      //        Text('Gender: ${patient?['gender']}'),
      //         Text('Gender: ${patient?['gender']}'),
      //          Text('Gender: ${patient?['gender']}'),
      //           Text('Gender: ${patient?['gender']}'),
      //            Text('Gender: ${patient?['gender']}'),
      //             Text('Gender: ${patient?['gender']}'),
      //              Text('Gender: ${patient?['gender']}'),
      //               Text('Gender: ${patient?['gender']}'),
      //     ],
      //   ),
      // ),
      drawer: Drawer(
        backgroundColor: Colors.black,
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
          ],
        ),
      ),
    );
=======
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
                  children: [
                    Icon(Icons.account_circle_rounded, size: 100),
                    const SizedBox(height: 10),
                    Text(
                      "  ${patient?['name']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "   ${patient?['email']}",
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
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await Authservice.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginroute, (_) => false);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
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
        ));
>>>>>>> 945c7363f4b24fa21fe65c3af7d25d88007a0194
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
