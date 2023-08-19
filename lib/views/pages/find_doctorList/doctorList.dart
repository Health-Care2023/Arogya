

class DoctorList {
  final String name;
  final String speciality;
  final String gender;

  DoctorList({
    required this.name,
    required this.speciality,
    required this.gender,
  });

  factory DoctorList.fromJson(Map<String, dynamic> json) {
    return DoctorList(
      name: json['name'],
      speciality: json['speciality'],
      gender: json['gender'],
    );
  }
}