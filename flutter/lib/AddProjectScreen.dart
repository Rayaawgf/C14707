import 'package:flutter/material.dart';

import 'Project.dart';
import 'ProjectAPI.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController etatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: etatController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: 'Etat',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String name = nameController.text;
                    String description = descriptionController.text;
                    String etat = etatController.text;

                    Project newProject = Project(
                      name: name,
                      description: description,
                      etat: etat,
                    );

                    try {
                      await API.addProject(newProject);
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('Failed to add project: $e');
                    }
                  },
                  child: Text('Envoyer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
