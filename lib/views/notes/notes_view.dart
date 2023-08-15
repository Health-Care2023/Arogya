import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/auth/bloc/auth_bloc.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';

import 'package:hello/services/chat/assets_manager.dart';
import 'package:hello/db/database_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../constants/routes.dart';
import '../profile_view.dart';

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
  String? _name;
  String? _email;
  int currentPageIndex = 0;
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
            icon: Icon(Icons.home, color: Color.fromARGB(255, 8, 26, 194)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.stethoscope,
                color: Color.fromARGB(255, 0, 0, 0)),
            label: 'Appointment',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.truckMedical,
                color: Color.fromARGB(255, 203, 4, 4)),
            label: 'Emergency',
          ),
          NavigationDestination(
            icon: Icon(Icons.medication, color: Colors.blue),
            label: 'TeleMedicines',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 10, top: 10),
          child: ImageSlideshow(
            width: double.infinity,

            /// Height of the [ImageSlideshow].
            height: 400,

            /// The page to show when first creating the [ImageSlideshow].
            initialPage: 0,

            /// The color to paint the indicator.
            indicatorColor: const Color.fromARGB(255, 0, 3, 6),

            /// The color to paint behind th indicator.
            indicatorBackgroundColor: Color.fromARGB(255, 186, 170, 190),

            /// The widgets to display in the [ImageSlideshow].
            /// Add the sample image file into the images folder
            children: [
              Image.asset(
                'asset/dept of health.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/improving-healthcare-west-bengal-medium-term-expenditure-framework_6.jpeg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/Swasthya sathi 2.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/Swasthya sathi.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/West-Bengal-Health-Scheme.jpg',
                fit: BoxFit.cover,
              ),
            ],

            /// Called whenever the page in the center of the viewport changes.
            onPageChanged: (value) {
              // print('Page changed: $value');
            },

            /// Auto scroll interval.
            /// Do not auto scroll with null or 0.
            autoPlayInterval: 3000,

            /// Loops back to first slide.
            isLoop: true,
            // alignment: Alignment.center,
            // child: const Text('Home', style: TextStyle(fontSize: 30)),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Appointment', style: TextStyle(fontSize: 30)),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Maps', style: TextStyle(fontSize: 30)),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('TeleMedicines', style: TextStyle(fontSize: 30)),
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

  // Widget bottomSheet() {
  //   return Container(
  //       height: 100.0,
  //       // width: MediaQuery.of(context).size.width,
  //       margin: EdgeInsets.symmetric(
  //         horizontal: 20,
  //         vertical: 20,
  //       ),
  //       child: Column(children: <Widget>[
  //         Text(
  //           "Choose your profile picture",
  //           style: const TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Row(children: <Widget>[
  //           TextButton.icon(
  //             icon: Icon(Icons.camera),
  //             label: Text("Camera"),
  //             onPressed: () {},
  //           )
  //         ])
  //       ]));
  // }


