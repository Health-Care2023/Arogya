import 'package:flutter/material.dart';
import 'package:hello/views/emergency/appoinment_page.dart';
import 'package:hello/views/views/main_view.dart';
// import 'package:hello/views/emergency/appoinment_page.dart';
import '../pages/find_doctorList/doctorList.dart';


class DoctorListPage extends StatefulWidget {
  final List<DoctorList> doctorsView;
  const DoctorListPage({super.key, required this.doctorsView});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  void navigateToDoctorDetails(DoctorList selectedDoctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorListPage(doctorsView: [selectedDoctor]),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white),
          // onPressed: () => Navigator.pushReplacement(context,'refresh'),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NotesView(),
              maintainState: false,
            ),
          ),
        ),
        title: const Text('Doctor List',
            style: TextStyle(fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 5, 14, 82),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.doctorsView.length, // Replace with the actual list length
        itemBuilder: (context, index) {
          final doctor = widget.doctorsView[index];
          return GestureDetector(
            onTap: () {
              navigateToDoctorDetails(doctor);
            },
            child: Card(
              // Customize the card widget to display doctor information
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(doctor.name),
                subtitle: Text('Speciality: ${doctor.speciality}'),
                // Add more doctor information as needed
              ),
            ),
          );
        },
      ),
    );
  }
}