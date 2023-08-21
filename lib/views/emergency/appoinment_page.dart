import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/views/pages/find_doctorList/Doctor.dart';
// ignore: depend_on_referenced_packages

import '../pages/Custom_dropdown.dart';
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
  String selectedSpecialty = ''; 
  String selectedGender = 'All';

List<String> DoctorNames = [];
List<String> filterDoctorNames = [];
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
    final String jsonString = await rootBundle.loadString('asset/doctor.json');
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
  List<String> dropDownSpecialties(List<Doctor> doctorSpeciality) {
    // Extract and deduplicate specialties
    Set<String> specialtySet = {};
    for (var doctor in doctorSpeciality) {
      specialtySet.add(doctor.name);
    }
    return specialtySet.toList();
  }
   List<String> extractNames(List<DoctorList> doctors) {
    // Extract and deduplicate specialties
    Set<String> nameSet = {};
    for (var doctor in doctors) {
      nameSet.add(doctor.name);
    }
    return nameSet.toList();
  }
   List<DoctorList> searchDoctors(String query) {
    return doctors.where((doctor) {
      final lowerQuery = query.toLowerCase();
      return (doctor.name.toLowerCase().contains(lowerQuery) || doctor.speciality.toLowerCase().contains(lowerQuery));
    }).toList();
  }
   // Function to filter doctors by specialty
  List<DoctorList> filterDoctorsBySpecialty(String specialty) {
    if (specialty.isEmpty) {
      return allDoctors();
    } else {
      return doctors.where((doctor) => doctor.speciality == specialty).toList();
    }
  }
  List<DoctorList> filterDoctors() {
    return doctors.where((doctor) {
      final lowerQuery = searchController.text.toLowerCase();
      return (doctor.name.toLowerCase().contains(lowerQuery) ||
          doctor.name.toLowerCase().contains(lowerQuery)) &&
          (selectedGender == 'All' || doctor.gender.toLowerCase() == selectedGender.toLowerCase()) &&
          (selectedSpecialty.isEmpty || doctor.speciality.toLowerCase() == selectedSpecialty.toLowerCase());
    }).toList();
  }

  void handleGridOptionClick(Doctor selectedDoctor) {
  setState(() {
    // selectedIndex = index;
    selectedSpecialty = selectedDoctor.name;
    filterDoctorNames = extractNames(filterDoctorsBySpecialty(selectedSpecialty));
  });
}
  @override
Widget build(BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
         scrollDirection: Axis.vertical,
        child: Column(
            children:[
                        TextField(
                            // onChanged: (value) => _runFilter(value),
                            controller: searchController,
                  onChanged: (value) {
                    setState(() {
                       if (value.isEmpty) {
                          DoctorNames.clear();
                        }
                        else{
                      DoctorNames = extractNames(searchDoctors(value));
                      print("hello doctors names ${DoctorNames.length}");
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
                          Row(
                            children: [
                              Expanded(
                                child: Container(         
                                  width: (MediaQuery.of(context).size.width)*0.30,      
                                    decoration: BoxDecoration(
                                            border: Border.all(width:1 , color: Colors.black),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                      child: CustomDropdown(
                                      options: ['All', 'Male', 'Female', 'Others'],
                                      onChanged: (selectedGender) {
                                        setState(() {
                                this.selectedGender = selectedGender;
                                     });
                                      print('Selected Gender: $selectedGender');
                                       },
                                    ),
                                 ),
                              ),
                                Expanded(
                                
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width)*0.66,                     
                                    decoration: BoxDecoration(
                                            border: Border.all(width:1 , color: Colors.black),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                      child: CustomDropdown(
                                      options: dropDownSpecialties(doctorSpeciality),
                                      onChanged: (selectedGender) {
                                        setState(() {
                                          this.selectedGender = selectedGender;
                                      });
                                      print('Selected Gender: $selectedGender');
                                       },
                                    ),
                                  ),
                                ),
                            ],
                          ),
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
                  itemCount: doctorSpeciality.length,
                  itemBuilder: (context, index) {
                    return buildDoctorCard(
                        doctorSpeciality[index], index, index == selectedIndex);
                  },
                ),
                if (DoctorNames.isNotEmpty)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      child: Container(
                        height: (MediaQuery.of(context).size.height)*0.5,
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1.0),
                        padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                        child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: DoctorNames.length,
                          itemBuilder: (context, index) {
                            final doctorName = DoctorNames[index];
                            final doctorBio = getDoctorBio(doctorName);
                            return ListTile(
                              leading: const Icon(FontAwesomeIcons.userDoctor),
                              title: Text(DoctorNames[index]),
                               subtitle: Text(doctorBio), 
                               hoverColor: Colors.black,
                              onTap: () {
                                searchController.text = DoctorNames[index];
                                print("hello ${doctorName}");
                              },
                            );
                          },
                        ),
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
        handleGridOptionClick(doctor);
        print('Hello ${ filterDoctorNames.length}');
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
  