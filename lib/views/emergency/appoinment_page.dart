import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/views/pages/find_doctorList/Doctor.dart';
import 'package:hello/views/emergency/doctor_list_page.dart';
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
  String selectedGender = '';

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
  //  List<String> extractExperience(List<DoctorList> doctors) {
  //   // Extract and deduplicate specialties
  //   Set<String> experienceSet = {};
  //   for (var doctor in doctors) {
      
  //     experienceSet.add(doctor.experience);
      

  //   }
  //   return experienceSet.toList();
  // }
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
 
List<DoctorList> filteredDoctors() {
  if (selectedGender.isEmpty && selectedSpecialty.isEmpty) {
    // Show an alert if neither gender nor speciality is selected
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please select at least one filter',
          style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          actions: [
             ElevatedButton(
            child: const Text('Ok',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ],
        );
      },
    );
    return []; 
  }

  // Apply filters based on selected gender and speciality
  List<DoctorList> filteredList = doctors;

  if (selectedGender.isNotEmpty && selectedGender != "All") {
    filteredList = filteredList.where((doctor) => doctor.gender == selectedGender).toList();
  }
  if (selectedSpecialty.isNotEmpty) {
    filteredList = filteredList.where((doctor) => doctor.speciality == selectedSpecialty).toList();
  }

  return filteredList;
}
  void handleGridOptionClick(Doctor selectedDoctor) async{
  // setState(() {
  //   // selectedIndex = index;
  //   selectedSpecialty = selectedDoctor.name;
  // });
  selectedSpecialty = selectedDoctor.name;
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DoctorListPage(doctorsView: filterDoctorsBySpecialty(selectedSpecialty)),
      maintainState: false,
    ),
  );
  // Refresh the AppointmentPage
  if (result == 'refresh') {
    setState(() {});
  }
}
 void handleSearchClick() async {
  // setState(() {
  //   // selectedIndex = index;
  //   filterDoctorNames = extractNames(filteredDoctors());
  // });
  //  print("Hello ${filterDoctorNames.length}");
   List <DoctorList> list  = filteredDoctors();
   if(list.isNotEmpty){
       final result = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorListPage(doctorsView: list),
          maintainState: false,
        ),
      );
       // Refresh the AppointmentPage
    if (result == 'refresh') {
      setState(() {});
    }
  }
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
                           Stack(
                         children: [
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              Container(         
                                      width: (MediaQuery.of(context).size.width)*0.80,      
                                        decoration: BoxDecoration(
                                                border: Border.all(width:1 , color: Colors.black),
                                                // borderRadius: BorderRadius.circular(10.0),
                                              ),
                                          child: CustomDropdown(
                                          text: 'Select Gender',
                                          options: ['All', 'Male', 'Female', 'Others'],
                                          onChanged: (selectedGender) {
                                            setState(() {
                                    this.selectedGender = selectedGender;
                                         });
                                          print('Selected Gender: $selectedGender');
                                           },
                                        ),
                                     ),
                                      Container(
                                        width: (MediaQuery.of(context).size.width)*0.80,                     
                                        decoration: BoxDecoration(
                                                border: Border.all(width:1 , color: Colors.black),
                                                // borderRadius: BorderRadius.circular(10.0),
                                              ),
                                          child: CustomDropdown(
                                          text: 'Choose Speciality',
                                          options: dropDownSpecialties(doctorSpeciality),
                                          onChanged: (selectedSpecialty) {
                                            setState(() {
                                              this.selectedSpecialty = selectedSpecialty;
                                          });
                                          print('Selected Gender: ${selectedSpecialty}');
                                           },
                                        ),
                                      ),
                                      Container(
                                         width: (MediaQuery.of(context).size.width)*0.80,
                                         alignment: Alignment.center,
                                         decoration: BoxDecoration(
                                                border: Border.all(width:0.2 , color: Colors.grey),
                                                // borderRadius: BorderRadius.circular(10.0),
                                              ),
                                        child: Container(
                                          width: (MediaQuery.of(context).size.width) * 0.40, // Set the width as desired
                                          decoration: BoxDecoration(
                                            // color: Colors.blue, // Set the background color
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromARGB(255, 8, 100, 176), // Make the button background transparent
                                              elevation: 2, // Remove elevation
                                            ),
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                ),
                                               SizedBox(width: 5), // Add some spacing between the icon and text
                                                Text(
                                                  'Search',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              handleSearchClick();
                                            },
                                          ),
                                        ),
                                      ),
            const SizedBox(height: 20),
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
                          ],),
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
                          shrinkWrap: true,
                          itemCount: DoctorNames.length,
                          itemBuilder: (context, index) {
                            final doctorName = DoctorNames[index];
                            final doctorBio = getDoctorBio(doctorName);
                            final isSelected = index == selectedIndex;

                            return Container(

                              color: isSelected ? Color.fromARGB(255, 207, 208, 208) : Colors.white,
                              child: ListTile(
                                
                                // selectedTileColor: isSelected ? Color.fromARGB(255, 227, 17, 17) : Colors.black,
                                leading: const Icon(FontAwesomeIcons.userDoctor),
                                title: Text(DoctorNames[index] ,
                                style: TextStyle(
                                      color: isSelected ? Color.fromARGB(255, 8, 8, 8) : Colors.black,
                                    ),),
                                 subtitle: Text(doctorBio , 
                                 style: TextStyle(
                                  color: isSelected ? Color.fromARGB(255, 11, 11, 11) : Colors.black,
                                ),), 
                                 hoverColor: Colors.black,
                                onTap: () {
                                   setState(() {
                                  searchController.text = DoctorNames[index];
                                  selectedIndex = index;
                                   });
                                  print("hello ${doctorName}");
                                },
                              ),
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
  
     final doctor = doctors.firstWhere((doc) => doc.name == doctorName);
    // ignore: prefer_adjacent_string_concatenation
    return "${doctor.speciality} | Experience: ${doctor.experience} | ${doctor.degree}";
 
  
  }


List<Doctor> doctorSpeciality = [
  Doctor(name: "Dentist", icon: const Icon(FontAwesomeIcons.tooth) ,selected: false),
  Doctor(name: "Cardiologist", icon: const Icon(FontAwesomeIcons.heartPulse , color: Color.fromARGB(255, 240, 26, 10),) ,selected: false),
  Doctor(name: "Pulmonologist", icon: const Icon(FontAwesomeIcons.lungs , color: Colors.pink) ,selected: false),
  Doctor(name: "Oncologist", icon: const Icon(FontAwesomeIcons.brain , color: Color.fromARGB(255, 240, 131, 167)) ,selected: false),
  Doctor(name: "General physician", icon: const Icon(FontAwesomeIcons.stethoscope , color: Colors.black) ,selected: false),
  Doctor(name: "Radiologist", icon: const Icon(FontAwesomeIcons.xRay) ,selected: false),
  Doctor(name: "Pediatrician", icon: const Icon(FontAwesomeIcons.baby) ,selected: false),
  Doctor(name: "Orthologist", icon: const Icon(FontAwesomeIcons.bone , color: Color.fromARGB(255, 170, 169, 169)) ,selected: false),
  // Add more doctors here
];
Widget buildDoctorCard(Doctor doctor,index,bool selected) {
    return GestureDetector(
       onTap: () {
        handleGridOptionClick(doctor);
        print('Hello ${ filterDoctorNames.length}');
         setState(() {
           for (var i = 0; i < doctorSpeciality.length; i++) {
          doctorSpeciality[i].selected = i == index;
        }
        // selectedIndex = index;
      });
       
      
        print('Hello ${index}');
      },
      child: Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color.fromARGB(255, 4, 100, 178)), 
              color: doctor.selected ? Colors.blue : Colors.white,
              boxShadow: doctor.selected
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
              color: doctor.selected ? Colors.white : Colors.black, // Change text color when selected
            ),),
          
          ],
        ),
      ),
    );
  }
}


