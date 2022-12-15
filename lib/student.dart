class Student {
  Student({
    required this.name,
    required this.age,
    required this.cgpa,
    required this.gender,
    required this.degreeProgram,
  });
  late final String name;
  late final int age;
  late final double cgpa;
  late final String gender;
  late final String degreeProgram;
  
  Student.fromJson(Map<String, dynamic> json){
    name = json['name'];
    age = json['age'];
    cgpa = json['cgpa'];
    gender = json['gender'];
    degreeProgram = json['degreeProgram'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['age'] = age;
    _data['cgpa'] = cgpa;
    _data['gender'] = gender;
    _data['degreeProgram'] = degreeProgram;
    return _data;
  }
}