import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/views/pages/find_doctorList/Doctor.dart';
// ignore: depend_on_referenced_packages

import '../pages/Gender_dropdown.dart';
import '../pages/find_doctorList/DoctorList.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int selectedIndex = -1;
  TextEditingController searchController = TextEditingController();
   List<DoctorList> doctors = [];
List<String> allDoctorNames = [
  // Add doctor names here
  "Varun",
  "Ankan",
  "Parthib",
  "Arka",
  "Soutik"
];

List<String> allSpecialties = [
  // Add doctor specialties here
  "oncologist",
  "cardiologist",
  "padaetrician",
  "dermatologists",
  "eye specialist"
];
List<String> filteredDoctorNames = [];
  @override
  void initState() {
    super.initState();
     loadDoctors();
  }

  @override
  void dispose() {
    super.dispose();
  }
Future<void> loadDoctors() async {
    // Load the JSON file from the assets directory
    final String jsonString = await rootBundle.loadString('assets/doctor.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      doctors = jsonList.map((json) => DoctorList.fromJson(json)).toList();
    });
  }

  List<DoctorList> allDoctors() {
    return doctors;
  }
  List<DoctorList> maleDoctors() {
    return doctors.where((doctor) => doctor.gender == "Male").toList();
  }
   List<DoctorList> femaleDoctors() {
    return doctors.where((doctor) => doctor.gender == "Female").toList();
  }
   List<DoctorList> otherDoctors() {
    return doctors.where((doctor) => doctor.gender == "Others").toList();
  }
   List<String> extractSpecialties(List<DoctorList> doctors) {
    // Extract and deduplicate specialties
    Set<String> specialtySet = {};
    for (var doctor in doctors) {
      specialtySet.add(doctor.speciality);
    }
    return specialtySet.toList();
  }
   List<DoctorList> searchDoctors(String query) {
    return doctors.where((doctor) {
      final lowerQuery = query.toLowerCase();
      return doctor.name.toLowerCase().contains(lowerQuery) ||
          doctor.speciality.toLowerCase().contains(lowerQuery);
    }).toList();
  }
  @override
Widget build(BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(20),
        
        //  width: (MediaQuery.of(context).size.width),
        // height: (MediaQuery.of(context).size.height),
        // color: Colors.red,
      child: SingleChildScrollView(
         scrollDirection: Axis.vertical,
        child: Column(
            children:[
            //    SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
                 
                     Row(
                       children: [
                         Expanded(

                            flex: 3,
                           child: TextField(
                            // onChanged: (value) => _runFilter(value),
                            controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      // Filter suggestions based on entered text
                       if (value.isEmpty) {
                          filteredDoctorNames.clear();
                        }
                        else{
                      filteredDoctorNames = allDoctorNames
                          .where((name) =>
                              name.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                        }
                    });
                  },
                            
                            decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                            labelText: "Search by name",
                            labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                            suffixIcon: const Icon(Icons.search,color: Color.fromARGB(255, 8, 4, 104),),
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
                            flex: 2,
                           child: Container(
                           
                              decoration: BoxDecoration(
                                      border: Border.all(width:1 , color: Colors.black),
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
          //            if (filteredDoctorNames.isNotEmpty)
          //            ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: filteredDoctorNames.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(filteredDoctorNames[index]),
          //       onTap: () {
          //         searchController.text = filteredDoctorNames[index];
          //       },
          //     );
          //   },
          // ),
              //  ),
            const SizedBox(height: 20),
            //   Stack(
            //     children: [ GridView.builder(
            //       physics: const NeverScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2, // You can adjust the number of columns here
            //       childAspectRatio: 1.0, // Ensure square grid items
            //       mainAxisExtent: (MediaQuery.of(context).size.height)*0.15,
            //     ),
            //     itemCount: doctors.length,
            //     itemBuilder: (context, index) {
            //         // First row with 2 doctors
            //         return buildDoctorCard(doctors[index],index, index == selectedIndex);
            //         },
            //       ),
            // ]),
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
                  itemCount: doctorSpeciality.length,
                  itemBuilder: (context, index) {
                    return buildDoctorCard(
                        doctorSpeciality[index], index, index == selectedIndex);
                  },
                ),
                if (filteredDoctorNames.isNotEmpty)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Color.fromARGB(255, 255, 255, 255).withOpacity(1.0),
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredDoctorNames.length,
                        itemBuilder: (context, index) {
                          final doctorName = filteredDoctorNames[index];
                          final doctorBio = getDoctorBio(doctorName);
                          return ListTile(
                            leading: Icon(FontAwesomeIcons.userDoctor),
                            title: Text(filteredDoctorNames[index]),
                             subtitle: Text(doctorBio), 
                            onTap: () {
                              searchController.text =
                                  filteredDoctorNames[index];
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


List<Doctor> doctorSpeciality = [
  Doctor(name: "Dentist", icon: const Icon(FontAwesomeIcons.tooth)),
  Doctor(name: "Cardiologist", icon: const Icon(FontAwesomeIcons.heartPulse , color: Color.fromARGB(255, 240, 26, 10),)),
  Doctor(name: "Pulmonologist", icon: const Icon(FontAwesomeIcons.lungs , color: Colors.pink)),
  Doctor(name: "Oncologist", icon: const Icon(FontAwesomeIcons.brain , color: Color.fromARGB(255, 240, 131, 167))),
  Doctor(name: "General physician", icon: const Icon(FontAwesomeIcons.stethoscope , color: Colors.black)),
  Doctor(name: "Radiologist", icon: const Icon(FontAwesomeIcons.xRay)),
  Doctor(name: "Pediatrician", icon: const Icon(FontAwesomeIcons.baby)),
  Doctor(name: "Orthologist", icon: const Icon(FontAwesomeIcons.bone , color: Color.fromARGB(255, 170, 169, 169))),
  // Add more doctors here
];
Widget buildDoctorCard(Doctor doctor,index,bool selected) {
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
                  color: Color.fromARGB(255, 99, 179, 245).withOpacity(0.5), // Glow color
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
            Text(doctor.name , 
             style: TextStyle(
              color: selected ? Colors.white : Colors.black, // Change text color when selected
            ),),
          ],
        ),
      ),
    );
  }
} 
  