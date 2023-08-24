import 'package:flutter/material.dart';
// import 'package:hello/views/emergency/appoinment_page.dart';
import '../pages/find_doctorList/DoctorList.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () => Navigator.pop(context,'refresh'),
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
          return Card(
            // Customize the card widget to display doctor information
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(doctor.name),
              subtitle: Text('Speciality: ${doctor.speciality}'),
              // Add more doctor information as needed
            ),
          );
        },
      ),
    );
  }
}