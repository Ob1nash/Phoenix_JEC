import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        backgroundColor: Color.fromARGB(255, 102, 215, 106),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Tasks',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  TaskCard(
                    title: 'Take a Walk',
                    description: 'Earn 20 EcoCoins per km',
                    icon: Icons.camera_alt,
                    onPressed: () {
                      _handleTaskCompletion(context);
                    },
                  ),
                  TaskCard(
                    title: 'Take Public Transport',
                    description: 'Earn 50 EcoCoins per km',
                    icon: Icons.directions_bus,
                    onPressed: () {
                      _handleTaskCompletion(context);
                    },
                  ),
                  TaskCard(
                    title: 'Plant a tree',
                    description: 'Earn 100 EcoCoins',
                    icon: Icons.shopping_bag,
                    onPressed: () {
                      _handleTaskCompletion(context);
                    },
                  ),
                  TaskCard(
                    title: 'More',
                    description: 'Earn 30 EcoCoins',
                    icon: Icons.shopping_bag,
                    onPressed: () {
                      _handleTaskCompletion(context);
                    },
                  ),
                  // Add more tasks as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleTaskCompletion(BuildContext context) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: firstCamera),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onPressed;

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32.0,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a Picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            // Handle image upload to server
            _uploadImage(image.path);
            Navigator.pop(context);
          } catch (e) {
            print('Error: $e');
          }
        },
      ),
    );
  }

  void _uploadImage(String imagePath) async {
    File imageFile = File(imagePath);
    try {
      var response = await http.post(
        Uri.parse('http://localhost:3000/fileupload'),
        body: {'file': imageFile},
      );
      if (response.statusCode == 200) {
        // File uploaded successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File uploaded successfully!'),
          ),
        );
      } else {
        // Error uploading file
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading file!'),
          ),
        );
      }
    } catch (e) {
      // Error handling request
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }
}
