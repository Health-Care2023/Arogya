import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/views/pages/find_doctorList/Doctor.dart';
import '../pages/Gender_dropdown.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int selectedIndex = -1;
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> doctorNames = [
    {"name": "varun", "specialist": "oncologist"},
    {"name": "soutik", "specialist": "cardiologist"},
    {"name": "parthib", "specialist": "padaetrician"},
    {"name": "arka", "specialist": "eye specialist"}
  ];
  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }

    return input[0].toUpperCase() + input.substring(1);
  }

  List<Map<String, String>> _foundUsers = [];
  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      results = doctorNames;
    } else {
      results = doctorNames.where((user) {
        return user["name"]!.contains(enteredKeyword.toLowerCase()) ||
            user["specialist"]!.contains(enteredKeyword.toLowerCase());
      }).toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      labelText: "Search by name",
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 8, 4, 104),
                      ),
                      // prefix: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: GenderDropdown(
                      genderOptions: ['All', 'Male', 'Female', 'Others'],
                      onChanged: (selectedGender) {
                        print('Selected Gender: $selectedGender');
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Stack(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisExtent: (MediaQuery.of(context).size.height) * 0.15,
                  ),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return buildDoctorCard(
                        doctors[index], index, index == selectedIndex);
                  },
                ),
                if (_foundUsers.isNotEmpty)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(1.0),
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) {
                          final doctorName = _foundUsers[index]["name"]!;
                          final doctorBio = getDoctorBio(doctorName);
                          return ListTile(
                            leading: Icon(FontAwesomeIcons.userDoctor),
                            title: Text(capitalizeFirstLetter(
                                _foundUsers[index]["name"]!)),
                            subtitle: Text(doctorBio),
                            onTap: () {
                              // searchController.text =
                              //     _foundUsers[index]["name"]!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getDoctorBio(String doctorName) {
    return "One-line bio of $doctorName";
  }

  List<Doctor> doctors = [
    Doctor(name: "Dentist", icon: Icon(FontAwesomeIcons.tooth)),
    Doctor(
        name: "Cardiologist",
        icon: Icon(
          FontAwesomeIcons.heartPulse,
          color: Color.fromARGB(255, 240, 26, 10),
        )),
    Doctor(
        name: "Pulmonologist",
        icon: Icon(FontAwesomeIcons.lungs, color: Colors.pink)),
    Doctor(
        name: "Oncologist",
        icon: Icon(FontAwesomeIcons.brain,
            color: Color.fromARGB(255, 240, 131, 167))),
    Doctor(
        name: "General physician",
        icon: Icon(FontAwesomeIcons.stethoscope, color: Colors.black)),
    Doctor(name: "Radiologist", icon: Icon(FontAwesomeIcons.xRay)),
    Doctor(name: "Pediatrician", icon: Icon(FontAwesomeIcons.baby)),
    Doctor(
        name: "Orthologist",
        icon: Icon(FontAwesomeIcons.bone,
            color: Color.fromARGB(255, 170, 169, 169))),
    // Add more doctors here
  ];
  Widget buildDoctorCard(Doctor doctor, index, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        print('Hello ${index}');
      },
      child: Container(
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color.fromARGB(255, 4, 100, 178)),
          color: selected ? Colors.blue : Colors.white,
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Color.fromARGB(255, 99, 179, 245)
                        .withOpacity(0.5), // Glow color
                    spreadRadius: 5, // Spread radius for the glow effect
                    blurRadius: 5, // Blur radius for the glow effect
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            doctor.icon,
            SizedBox(height: 8),
            Text(
              doctor.name,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.black, // Change text color when selected
              ),
            ),
          ],
        ),
      ),
    );
  }
}
