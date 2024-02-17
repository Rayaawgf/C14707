import 'package:flutter/material.dart';
import 'AddProjectScreen.dart';
import 'Project.dart';
import 'ProjectAPI.dart';
import 'EditProjectScreen.dart';

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _refreshProjects();
  }

  Future<void> _refreshProjects() async {
    setState(() {
      _projectsFuture = API.getAllProjects();
    });
  }

  void _navigateToAddProjectScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProjectScreen()),
    ).then((_) {
      _refreshProjects();
    });
  }

  void _navigateToEditProjectScreen(Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProjectScreen(project: project)),
    ).then((_) {
      _refreshProjects();
    });
  }

  void _deleteProject(Project project) async {
    if (project.id != null) {
      await API.deleteProject(project.id!);
      _refreshProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Manager'),
        backgroundColor: Colors.white30,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshProjects,
          ),
        ],
      ),
      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Project>? projects = snapshot.data;
            if (projects != null && projects.isNotEmpty) {
              return ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  Project project = projects[index];
                  return ListTile(
                    title: Text(project.name),
                    subtitle: Text(project.etat),
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _navigateToEditProjectScreen(project),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteProject(project),
                    ),
                    onTap: () {
                      // Navigation vers l'écran de détails du projet
                    },
                  );
                },
              );
            } else {
              return Center(child: Text('No projects available'));
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProjectScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProjectListScreen(),
    );
  }
}
