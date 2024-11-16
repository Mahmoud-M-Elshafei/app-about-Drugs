import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Admin_Page.dart';
import 'SignUp_Page.dart';
import 'Data_Firebase.dart';
import 'firebase_options.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Ddrug',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login_Page(),
    );
  }
}

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login_Page> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  final RegExp emailRegExp =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  Future<void> _authenticate(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check if there's internet connectivity
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

    // Proceed with authentication
    final adminSnapshot = await FirebaseFirestore.instance
        .collection('Admin')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (adminSnapshot.docs.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Admin_Page()),
      );
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Drug_Data()),
        );
      } on FirebaseAuthException {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Invalid Email or Password. Please try again.'),
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: Image.asset(
                          'images/a22.jpg',
                          height: 150,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
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
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Your Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        obscureText: _isObscure,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Log In'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _authenticate(context);
                    }
                  },
                ),
                const SizedBox(height: 2.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 16.0), // Add some space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}