class User {
  final String fullNametext;
  final String company;
  final int age;

  User({
    required this.fullNametext,
    required this.company,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullNametext: json['full_name'] as String,
        company: json['company'] as String,
        age: json['age'] as int,
      );
}