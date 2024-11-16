import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login_Page.dart';

class Profile_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24, fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent, // Change app bar background color
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut(); // Sign out the user
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login_Page()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ProfilePageContent(),
      ),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.authStateChanges().first, // Listen for the first authentication state change
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            );
          } else {
            final user = snapshot.data;
            if (user == null) {
              // User is not logged in
              return Text(
                'No user logged in',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              );
            } else {
              return Card(
                elevation: 4,
                margin: EdgeInsets.all(16),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Welcome! You are logged in as:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        user.email ?? 'Email not available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 16),
                      // You can add more information here like display name, profile picture, etc.
                    ],
                  ),
                ),
              );
            }
          }
        }
      },
    );
  }
}
