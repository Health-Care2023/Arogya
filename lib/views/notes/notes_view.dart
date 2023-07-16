import 'package:flutter/material.dart';
import 'package:hello/constants/constants.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/chat/assets_manager.dart';
import 'package:hello/services/crud/notes_service.dart';
import 'package:hello/views/profile_view.dart';

import '../../constants/routes.dart';
//import '../../enum/menu_action.dart';

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
                  //  Icon(Icons.account_circle_rounded, size: 100),
                    imageProfile(),
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
        ));
  }
}
Widget imageProfile() {
      return Center(
        child: Stack(
          children: <Widget>[
           CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(AssetsManager.userImage),
            ),
             Positioned(
                bottom: 21.0,
                right: 21.0,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                  Icons.camera_alt,
                  size: 25.0,
                  color: Colors.teal,
                  )
                 ), 
                )
          ],
        ),
      )
    ;
  }
  Widget bottomSheet(){
    return Container(
      height: 100.0,
     // width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children:<Widget>[
          Text(
            "Choose your profile picture",
            style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Camera"),
                
                onPressed: () {

                },
              )
            ]
          )
        ]
      )
    );
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
