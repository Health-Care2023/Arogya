import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/views/pages/find_doctorList/Doctor.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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
                           child: TextField(
                            // onChanged: (value) => _runFilter(value),
                            decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                            labelText: "Search by name/speciality",
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
                         const SizedBox(width: 5),
                         Expanded(
                           child: TextField(
                            // onChanged: (value) => _runFilter(value),
                            decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                            hintText: "Search by speciality",
                            hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                            suffixIcon: const Icon(Icons.search,color: Color.fromARGB(255, 8, 4, 104),),
                            // prefix: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                              ),
                             ),
                           ),
                         ),
                       ],
                     ),
                     
              //  ),
            const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // You can adjust the number of columns here
                childAspectRatio: 1.0, // Ensure square grid items
                mainAxisExtent: (MediaQuery.of(context).size.height)*0.15,
              ),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                  // First row with 2 doctors
                  return buildDoctorCard(doctors[index],index);
                  },
                ),
              ]
            ),
        ),
      );
  }
}
List<Doctor> doctors = [
  Doctor(name: "Dentist", icon: Icon(FontAwesomeIcons.tooth)),
  Doctor(name: "Cardiologist", icon: Icon(FontAwesomeIcons.heartPulse , color: Color.fromARGB(255, 240, 26, 10),)),
  Doctor(name: "Pulmonologist", icon: Icon(FontAwesomeIcons.lungs , color: Colors.pink)),
  Doctor(name: "Oncologist", icon: Icon(FontAwesomeIcons.brain , color: Color.fromARGB(255, 240, 131, 167))),
  Doctor(name: "General physician", icon: Icon(FontAwesomeIcons.stethoscope , color: Colors.black)),
  Doctor(name: "Radiologist", icon: Icon(FontAwesomeIcons.xRay)),
  Doctor(name: "Pediatrician", icon: Icon(FontAwesomeIcons.baby)),
  Doctor(name: "Orthologist", icon: Icon(FontAwesomeIcons.bone , color: Color.fromARGB(255, 170, 169, 169))),
  // Add more doctors here
];
Widget buildDoctorCard(Doctor doctor,index) {
    return GestureDetector(
       onTap: () {
        print('Hello ${index}');
      },
      child: Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color.fromARGB(255, 4, 100, 178)), 
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            doctor.icon,
            SizedBox(height: 8),
            Text(doctor.name),
          ],
        ),
      ),
    );
  }