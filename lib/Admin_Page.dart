import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Feedback_Result.dart';
import 'Login_Page.dart';
import 'firebase_options.dart'; // Import your Firebase configuration
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {           //Email://admin@admin.com ///
    return const MaterialApp(
      home: Admin_Page(),
    );
  }
}

class Admin_Page extends StatefulWidget {
  const Admin_Page({super.key});

  @override
  _Admin_Page_State createState() => _Admin_Page_State(); ///Email://admin@admin.com ///
}

class _Admin_Page_State extends State<Admin_Page> {
  final TextEditingController _collectionController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final List<TextEditingController> _fieldControllers = [];
  final List<TextEditingController> _valueControllers = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _fieldControllers.add(TextEditingController());
    _valueControllers.add(TextEditingController());
  }

  void _AddNew_Field() {
    setState(() {
      _fieldControllers.add(TextEditingController());
      _valueControllers.add(TextEditingController());
    });
  }
  void _Save_Data() {
    setState(() {
      _saving = true;
    });

    bool isEmptyField = false; // Flag to check if any field is empty
    Map<String, dynamic> data = {};
    for (int i = 0; i < _fieldControllers.length; i++) {
      String fieldName = _fieldControllers[i].text.trim();
      String fieldValue = _valueControllers[i].text.trim();
      if (fieldName.isNotEmpty && fieldValue.isNotEmpty) {
        data[fieldName] = fieldValue;
      } else {
        isEmptyField = true; // Set flag to true if any field is empty
      }
    }

    if (isEmptyField) {
      setState(() {
        _saving = false;
      });
      _Error_Alert("Some thing wrong "); // Show error alert
      return; // Exit function if any field is empty
    }

    // If no field is empty, proceed with saving data
    FirebaseFirestore.instance
        .collection(_collectionController.text)
        .doc(_documentController.text)
        .set(data)
        .then((_) {
      setState(() {
        _saving = false;
      });
      _Success_Alert();
      for (var controller in _fieldControllers) {
        controller.clear();
      }
      for (var controller in _valueControllers) {
        controller.clear();
      }
    }).catchError((error) {
      setState(() {
        _saving = false;
      });
      _Error_Alert(error.toString());
    });
  }


  void _Success_Alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Data saved successfully."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _Error_Alert(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.feedback,color: Colors.black,),
            onPressed: () {
              FirebaseAuth.instance.signOut(); // Sign out the user
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Admin_Feedback()),
              );
            },
            tooltip: 'See Feedback ', // Tooltip text //show what this icon do
          ),
          IconButton(
            icon: Icon(Icons.logout,color: Colors.black,),
            onPressed: () {
              FirebaseAuth.instance.signOut(); // Sign out the user
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login_Page()),
              );
            },
            tooltip: 'LogOut ', // Tooltip text //show what this icon do

          ),
        ],
        automaticallyImplyLeading: false, // Remove back arrow
        title: const Text('Admin Page',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _collectionController,
              decoration: const InputDecoration(labelText: 'Disease Name'),
            ),
            TextField(
              controller: _documentController,
              decoration: const InputDecoration(labelText: 'Scientific Name'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _fieldControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _fieldControllers[index],
                          decoration: const InputDecoration(labelText: 'Drug Name'),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _valueControllers[index],
                          decoration: const InputDecoration(labelText: ' Price / Dosage'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: _saving
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _Save_Data,
                child: const Text('Save Data'),
              ),
            ),
            const SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                onPressed: _AddNew_Field,
                child: const Text('Add New Field'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
