

class DoctorList {
  final String name;
  final String speciality;
  final String gender;
  final String experience;
  final String degree;

  DoctorList({
    required this.name,
    required this.speciality,
    required this.gender,
    required this.experience,
    required this.degree,
  });

  factory DoctorList.fromJson(Map<String, dynamic> json) {
    return DoctorList(

      name: json['name'],
      speciality: json['speciality'],
      gender: json['gender'],
      experience: json['experience'],
      degree: json['degree'],
    );
  }
}