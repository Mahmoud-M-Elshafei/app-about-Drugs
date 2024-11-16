import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login_Page.dart';
import 'Data_Firebase.dart';
import 'firebase_options.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');
  final RegExp phoneRegExp = RegExp(r'^[0-9]{11}$');
  SignUpPage({Key? key});
  Future<void> _performSignUp(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No internet connection. Please check your network settings.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the method if there's no internet connection
    }

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('Admin').doc('Users').collection('UserData').add({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        // Add more fields as needed
      });

      // User registration successful, navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Drug_Data()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String errorMessage = 'An error occurred, please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Failed to sign up: $e');
      // Handle other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Ensure the entire layout moves up when the keyboard is open
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the LoginPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login_Page()),
            );
          },
        ),
      ),
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 6.0),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty|| !RegExp(r'^[a-zA-Z].*').hasMatch(value)) {  //user should input at least on alphabet
                          return 'Please Enter Your Email';
                        }
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please Enter a Valid Email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        if (!nameRegExp.hasMatch(value)) {
                          return 'Please Enter a Valid Name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Phone Number';
                        }
                        if (!phoneRegExp.hasMatch(value)) {
                          return 'Please Enter a Valid Phone Number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 6.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blue, // تغيير لون زر الإنشاء
                      ),
                      child: const Text('Sign Up', style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save the sign-up data and navigate to the home screen
                          _performSignUp(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50.2),
              child: Image.asset(
                'images/a22.jpg', // Replace this with  logo asset path
                height: 150,
                width: 150, // Adjust the height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
