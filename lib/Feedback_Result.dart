import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Admin_Feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Feedback'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Admin').doc('Feedback').snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<String, dynamic>? feedbackData = snapshot.data?.data() as Map<String, dynamic>?;

          if (feedbackData == null || feedbackData.isEmpty) {
            return Center(
              child: Text('No feedback available.'),
            );
          }

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: feedbackData.length,
                itemBuilder: (context, index) {
                  String feedbackKey = 'Feedback${index + 1}';
                  Map<String, dynamic> feedback = feedbackData[feedbackKey] as Map<String, dynamic>;
                  String feedbackText = feedback['feedback'];
                  String imageUrl = feedback['imageUrl'] ?? ''; // If imageUrl is null, assign an empty string

                  return Card(
                    child: InkWell(
                      onTap: () {
                        // Handle tap event here
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feedbackText,
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.0),
                            imageUrl.isNotEmpty
                                ? GestureDetector(
                              onTap: () {
                                // Handle tap event on image here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ImageFullScreen(imageUrl)),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageFullScreen extends StatelessWidget {
  final String imageUrl;

  ImageFullScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Image'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
