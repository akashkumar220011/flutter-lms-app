class CourseModel {
  final int? id;
  final String title;
  final String description;
  final int teacherId;

  CourseModel({
    this.id,
    required this.title,
    required this.description,
    required this.teacherId,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      teacherId: map['teacherId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacherId': teacherId,
    };
  }
}
