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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

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
            icon: Icon(Icons.home,
            color: Color.fromARGB(255, 5, 14, 82)),
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
          // NavigationDestination(
          //   icon: Icon(Icons.medication,
          //   color: Color.fromARGB(255, 5, 14, 82)),
          //   label: 'Tele-Medicine',
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: 
          <Widget>[
            Column(children: [
              const SizedBox(height: 10,),
              Row(children: [
                const SizedBox(width: 10,),
                SizedBox(
                  width:  (MediaQuery.of(context).size.width)*(0.45),
                  height: (MediaQuery.of(context).size.height)*(0.15),
                child: FloatingActionButton.extended(
                      //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
                      label: const Text(
                        'Book Lab Tests',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // <-- Text
                      backgroundColor: Color.fromARGB(255, 229, 230, 234),
                      icon: new Icon(FontAwesomeIcons.stethoscope),
                      onPressed: () {
                        
                      },
                    ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: (MediaQuery.of(context).size.width)*(0.45),
                height: (MediaQuery.of(context).size.height)*(0.15),
                child: FloatingActionButton.extended(
                      //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
                      label: const Text(
                        'Medical History',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // <-- Text
                      backgroundColor:Color.fromARGB(255, 229, 230, 234),
                      icon: new Icon(FontAwesomeIcons.bookMedical),
                      onPressed: () {
                        
                      },
                    ),
              ),
              ],),
              const SizedBox(height: 5,),
               Row(children: [
                const SizedBox(width: 10,),
                SizedBox(
                  width:  (MediaQuery.of(context).size.width)*(0.45),
                  height: (MediaQuery.of(context).size.height)*(0.15),
                child: FloatingActionButton.extended(
                      //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
                      label: const Text(
                        'Blood Group',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // <-- Text
                      backgroundColor: Color.fromARGB(255, 229, 230, 234),
                      icon: new Icon(FontAwesomeIcons.droplet,
                      color: Color.fromARGB(255, 209, 51, 39),
                      ),
                      onPressed: () { 
                      },
                    ),
                    ),
                    const SizedBox(width: 10),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)*(0.45),
                        height: (MediaQuery.of(context).size.height)*(0.15),
                        child: FloatingActionButton.extended(
                              //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
                              label: const Text(
                                'Tele-Medicine',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ), // <-- Text
                              backgroundColor:Color.fromARGB(255, 229, 230, 234),
                              icon: new Icon(FontAwesomeIcons.phone),
                              onPressed: () {
                                
                              },
                            ),
                      ),
                    ]
                    ),
                    
              Container(
              margin: const EdgeInsets.only(left: 10, right: 16, top: 10),
              child: ImageSlideshow(
                 width: double.infinity,
            
                /// Height of the [ImageSlideshow].
                 height: (MediaQuery.of(context).size.height)*0.47,
                /// The page to show when first creating the [ImageSlideshow].
                initialPage: 0,
            
                /// The color to paint the indicator.
                indicatorColor: Colors.blue,
            
                /// The color to paint behind th indicator.
                indicatorBackgroundColor: Colors.grey,
            
                /// The widgets to display in the [ImageSlideshow].
                /// Add the sample image file into the images folder
                children: [
                  Image.asset(
                    'asset/dept_of_health.jpg',
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
                  print('Page changed: $value');
                },
            
                /// Auto scroll interval.
                /// Do not auto scroll with null or 0.
                autoPlayInterval: 1000,
            
                /// Loops back to first slide.
                isLoop: true,
                // alignment: Alignment.center,
                // child: const Text('Home', style: TextStyle(fontSize: 30)),
                
              ),
            ),
                  ],
                ),
                Container(
              alignment: Alignment.center,
              child: const Text('Emergency', style: TextStyle(fontSize: 30)),
            ),
             Container(
              alignment: Alignment.bottomCenter,
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
            child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: const Text("He'd have you all unravel at the"),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[200],
              child: const Text('Heed not the rabble'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[300],
              child: const Text('Sound of screams but the'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[400],
              child: const Text('Who scream'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[500],
              child: const Text('Revolution is coming...'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[600],
              child: const Text('Revolution, they...'),
            ),
              ],
            ),
            ),
          ][currentPageIndex],
      ),
      floatingActionButton: Container(
        width: (MediaQuery.of(context).size.width)*(0.20),
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
