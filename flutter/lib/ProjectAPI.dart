import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Project.dart'; // Importer correctement le modèle de projet

class API {
  static const String baseUrl =
      'https://87a3-41-188-106-98.ngrok-free.app/projects'; // Mettre à jour l'URL de base

  static Future<List<Project>> getAllProjects() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Project> projects =
          body.map((dynamic item) => Project.fromJson(item)).toList();
      return projects;
    } else {
      throw "Failed to load projects"; // Utilisation de throw pour lancer une exception en cas d'échec
    }
  }

  static Future<Project> getProject(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$id')); // Utilisation de l'ID dans l'URL
    if (response.statusCode == 200) {
      return Project.fromJson(json.decode(response.body));
    } else {
      throw "Failed to load project";
    }
  }

  static Future<void> addProject(Project project) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(project
          .toJson()), // Utilisation de jsonEncode pour convertir l'objet en JSON
    );
    if (response.statusCode != 200) {
      throw "Failed to add project";
    }
  }

  static Future<void> updateProject(Project project) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${project.id}'), // Utilisation de l'ID dans l'URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(project.toJson()),
    );
    if (response.statusCode != 200) {
      throw "Failed to update project";
    }
  }

  static Future<void> deleteProject(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$id')); // Utilisation de l'ID dans l'URL
    if (response.statusCode != 200) {
      throw "Failed to delete project";
    }
  }
}
