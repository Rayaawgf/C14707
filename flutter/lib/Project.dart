class Project {
  final int? id;
  final String name;
  final String description;
  final String etat;

  Project(
      {this.id,
      required this.name,
      required this.description,
      required this.etat});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      etat: json['etat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'etat': etat,
    };
  }
}
