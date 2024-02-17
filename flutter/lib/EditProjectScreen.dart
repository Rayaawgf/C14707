import 'package:flutter/material.dart';
import 'Project.dart';
import 'ProjectAPI.dart';

class EditProjectScreen extends StatefulWidget {
  final Project project;

  EditProjectScreen({required this.project});

  @override
  _EditProjectScreenState createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _etatController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.name);
    _descriptionController =
        TextEditingController(text: widget.project.description);
    _etatController = TextEditingController(text: widget.project.etat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Project'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _etatController,
              decoration: InputDecoration(
                labelText: 'Etat',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _updateProject();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProject() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    String etat = _etatController.text;

    Project updatedProject = Project(
      id: widget.project.id,
      name: name,
      description: description,
      etat: etat,
    );

    await API.updateProject(updatedProject);

    // Retour à l'écran précédent après la mise à jour du projet
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _etatController.dispose();
    super.dispose();
  }
}
