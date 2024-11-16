import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Feedback_Page extends StatefulWidget {
  @override
  _Feedback_Page createState() => _Feedback_Page();
}

class _Feedback_Page extends State<Feedback_Page> {
  final TextEditingController feedbackController = TextEditingController();
  int feedbackCount = 0;
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _Submit_Feedback(BuildContext context) async {
    String feedback = feedbackController.text;

    if (feedback.isNotEmpty) {
      // Increment feedback count
      feedbackCount++;

      if (_image != null) {
        // Upload image to Firebase Storage
        final Reference storageReference = FirebaseStorage.instance.ref().child('feedback_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await storageReference.putFile(_image!);

        // Get image URL
        final String imageUrl = await storageReference.getDownloadURL();

        // Save feedback and image URL to Firestore
        FirebaseFirestore.instance.collection('Admin').doc('Feedback').update({
          'Feedback$feedbackCount': {
            'feedback': feedback,
            'imageUrl': imageUrl,
          }
        });
      } else {
        // Save feedback without image URL to Firestore
        FirebaseFirestore.instance.collection('Admin').doc('Feedback').update({
          'Feedback$feedbackCount': {
            'feedback': feedback,
          }
        });
      }

      // Show feedback submitted dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Feedback Submitted'),
            content: Text('Thank you for your feedback!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // Clear feedback text field and image
      feedbackController.clear();
      setState(() {
        _image = null;
      });
    } else {
      // Show alert for empty feedback field
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter your feedback before submitting.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback ',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
        ),
        backgroundColor: Colors.blue, // Change app bar background color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: feedbackController,
                decoration: InputDecoration(
                  labelText: 'Enter your feedback',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: InkWell(
                    onTap: () => _getImage(ImageSource.camera),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                ),
                maxLines: null,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _getImage(ImageSource.gallery),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change button background color
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_library),
                    SizedBox(width: 8),
                    Text(
                      'Select Image',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              _image != null
                  ? Image.file(
                _image!,
                height: 200,
                fit: BoxFit.cover,
              )
                  : SizedBox(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _Submit_Feedback(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change button background color
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit Feedback',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
